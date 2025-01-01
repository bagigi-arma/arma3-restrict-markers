#include "script_component.hpp"
/*
 * Function has 2 modes:
 * Serializes all of a marker's sharable attributes into an Array, for easy passing of that data to other specific players.
 * Unserializes an Array of marker attributes and applies them to a given local marker.
 */

params ["_marker", ["_data", []], ["_owner", player]];

if (_data isEqualTo []) then { // Serialize
	_data = [
		markerChannel _marker,
		markerColor _marker,
		markerDir _marker,
		markerPos _marker,
		markerSize _marker,
		markerText _marker,
		markerType _marker,
		markerPolyline _marker
	];
	_data // Return serialized marker data, to be inserted into localMarkers HashMap
} else { // Unserialize
	_data params ["_channel", "_color", "_dir", "_pos", "_size", "_text", "_type", "_polyLine"];

	// If marker does not exist on the current machine, create it as a local instance
	if !((GVAR(localMarkers) getOrDefault [_marker, ""]) isEqualType []) then {
		// When modifying any of a marker's attributes on the map, Arma creates a new one. Delete any old marker near the new one's position that is most likely the same old one.
		private _nearestMarker = [allMapMarkers, _pos] call BIS_fnc_nearestPosition;
		if (
			(_nearestMarker isNotEqualTo [0,0,0]) && 
			{(markerPos _nearestMarker) distanceSqr _pos < 4}
		) then {
			[_nearestMarker] call FUNC(discardMarker);
		};

		_marker = createMarkerLocal [[_marker] call FUNC(stampMarker), _pos, _channel, _owner];
	} else {
		// Marker already exists and was only moved by the remote user
		GVAR(updateByEvent) = _marker;
		_marker setMarkerPosLocal _pos;
	};

	GVAR(updateByEvent) = _marker;
	// Update marker with unserialized data
	_marker setMarkerColorLocal _color;
	_marker setMarkerDirLocal _dir;
	_marker setMarkerSizeLocal _size;
	_marker setMarkerTextLocal _text;
	_marker setMarkerTypeLocal _type;
	if (_polyLine isNotEqualTo []) then {
		_marker setMarkerPolylineLocal _polyLine;
	};
	GVAR(updateByEvent) = objNull;

	// Add new marker to this machine's localMarkers HashMap
	GVAR(localMarkers) set [_marker, [_marker] call FUNC(serializeMarker)];
	GVAR(syncMarkers) = true;
};

#include "script_component.hpp"

#include "initSettings.inc.sqf"

[QGVAR(toggleRestriction), {
	params ["_enabled"];
	[QGVAR(enabled), _enabled, true, "mission"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

// Receive all local markers from a remote player and integrate them into ones own local markers
[QGVAR(shareAllMarkersEvent), {
	params ["_remoteMarkers"]; // Hashmap containing all markers as serialized data
	{
		private _key = _x;
		private _value = _y;

		// Unserialize the received marker
		[_key, _value] call FUNC(serializeMarker);
	} forEach _remoteMarkers;
}] call CBA_fnc_addEventHandler;

// Receive a single marker position update after a nearby player moved it
[QGVAR(moveSingleMarkerEvent), {
	params ["_marker", "_markerPos"];

	_marker = [_marker] call FUNC(stampMarker);
	_marker setMarkerPosLocal _markerPos;
}] call CBA_fnc_addEventHandler;

// Register the event handlers for processing markers
addMissionEventHandler [
	"MarkerCreated",
	FUNC(markerCreatedEvent)
];
addMissionEventHandler [
	"MarkerDeleted",
	FUNC(markerDeletedEvent)
];
addMissionEventHandler [
	"MarkerUpdated",
	FUNC(markerUpdatedEvent)
];

GVAR(localMarkers) = createHashMap;

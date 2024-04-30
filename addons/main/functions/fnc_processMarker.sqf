#include "script_component.hpp"
/*
 * Replace global marker with a local copy
 *
 * The local marker name includes a "magic tag" so we can break an infinite loop of processing,
 * as creating a new marker within the markerCreated EH would continue calling it recursively without stopping.
 *
 * NOTE: This function must be "spawned" (run in scheduled space) to avoid a crash.
 */

params ["_marker", "_owner"];

// Wait for ACE to maybe set direction
_marker setMarkerAlphaLocal 0;
uiSleep 0.25;

private _markerChannel = markerChannel _marker;
private _markerColor = markerColor _marker;
private _markerDir = markerDir _marker;
private _markerPolyline = markerPolyline _marker;
private _markerPos = markerPos _marker;
private _markerSize = markerSize _marker;
private _markerText = markerText _marker;
private _markerType = markerType _marker;

// Delete global marker so JIP don't get it later.
[_marker] spawn {
	params ["_marker"];

	// Move marker out of the way
	_marker setMarkerPosLocal [-1000, -1000];

	// Give some time for network sync
	uiSleep 5;

	deleteMarker _marker;
};

private _localMarker = createMarkerLocal [
	// Marker name is important.
	//
	// Including text from original name enables user
	// interaction. Stamping with magic tag allows EH to break
	// infinite loop. Stamping with local client ID makes it
	// unique so it doesn't get deleted when other players delete
	// their version of the marker.
	[_marker, clientOwner] call FUNC(stampMarker),
	_markerPos,
	_markerChannel,
	_owner
];
_localMarker setMarkerColorLocal _markerColor;
if (count _markerPolyline >= 4) then {
	// [x1, y1, x2, y2, ..., xn, yn]
	_localMarker setMarkerPolylineLocal _markerPolyline;
};
_localMarker setMarkerDirLocal _markerDir;
_localMarker setMarkerSizeLocal _markerSize;
_localMarker setMarkerTextLocal _markerText;
//_localMarker setMarkerTextLocal format ["LOCAL %1", _markerText];
_localMarker setMarkerTypeLocal _markerType;

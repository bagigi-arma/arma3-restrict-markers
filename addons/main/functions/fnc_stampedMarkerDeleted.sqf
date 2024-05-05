#include "script_component.hpp"
/*
 * Handle deletion of a stamped marker
 */

params ["_owner", "_marker"];

if (
	[_owner] call FUNC(canShare)
) then {
	// Re-stamp with own client ID before deleting
	private _localMarker = [_marker] call FUNC(stampMarker);
	deleteMarkerLocal _localMarker;
	GVAR(localMarkers) deleteAt _localMarker;
};

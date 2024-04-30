#include "script_component.hpp"
/*
 * Handle deletion of a stamped marker
 */

params ["_owner", "_marker"];

if (
	[_owner] call FUNC(canShare)
) then {
	// Re-stamp with own client ID before deleting
	deleteMarkerLocal ([_marker, clientOwner] call FUNC(stampMarker));
};

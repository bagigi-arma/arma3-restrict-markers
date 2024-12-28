#include "script_component.hpp"
/*
 * Handle the markerDeleted event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerDeleted
 */

params ["_marker", "_local", "_deleter"];

// Only handle stamped markers
if !([_marker] call FUNC(isMarkerStamped)) exitWith {};

// Remove marker from HashMap
GVAR(localMarkers) deleteAt _marker;
GVAR(syncMarkers) = true;

// Do not propagate event if sharing is currently disabled
if (!GVAR(sharingEnabled)) exitWith {};

// Run deletion event on Dedicated Server when one's own marker was deleted
if (!isDedicated && {[_marker] call FUNC(isMarkerOwnedBy)}) then {
	[QGVAR(deleteStampedMarkerEvent), [_marker, player, true]] call CBA_fnc_serverEvent;
};

// If deletion was triggered by a CBA event, do not propagate it again.
if (GVAR(deletionByEvent) isEqualTo _marker) exitWith {GVAR(deletionByEvent) = objNull};

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance) max GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];
_nearPlayers = _nearPlayers select {[player, _x] call FUNC(canShare)};

// Run deletion event on nearby clients
[QGVAR(deleteStampedMarkerEvent), [_marker, player], _nearPlayers] call CBA_fnc_targetEvent;

if (GVAR(showNotifications) == NOTIFY_ALL) then {
	[LLSTRING(DeletedMarkerFor), _nearPlayers] call FUNC(notifyList);
};

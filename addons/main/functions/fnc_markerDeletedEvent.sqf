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

// If deletion was triggered by a CBA event, do not propagate it again.
if (GVAR(deletionByEvent) isEqualTo _marker) exitWith {GVAR(deletionByEvent) = objNull};

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance) max GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];
_nearPlayers = _nearPlayers select {[_x] call FUNC(canShare)};

// Run deletion event on nearby clients
[QGVAR(deleteStampedMarkerEvent), [_marker, player], _nearPlayers] call CBA_fnc_targetEvent;

[LLSTRING(DeletedMarkerFor), _nearPlayers] call FUNC(notifyList);

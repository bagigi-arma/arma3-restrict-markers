#include "script_component.hpp"
/*
 * Handle the markerDeleted event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerDeleted
 */

params ["_marker", "_local", "_deleter"];

// Only handle stamped markers
if !([_marker] call FUNC(isMarkerStamped)) exitWith {};

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];

// Run deletion event on nearby clients
[QGVAR(deleteStampedMarkerEvent), [_marker], _nearPlayers] call CBA_fnc_targetEvent;

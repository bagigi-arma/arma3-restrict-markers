#include "script_component.hpp"
/*
 * Handle the markerUpdated event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerUpdated
 * 
 * This code will only run when moving a marker, as changing any marker attributes will replace it with a completely new marker.
 */

params ["_marker", "_local"];

// Only handle stamped markers
if !([_marker] call FUNC(isMarkerStamped)) exitWith {};

private _markerData = [_marker] call FUNC(serializeMarker);
GVAR(localMarkers) set [_marker, _markerData];

// Do not propagate event if sharing is currently disabled
if (!GVAR(sharingEnabled)) exitWith {};

// If update was triggered by a CBA event or Stamped Marker creation, do not propagate it again.
if (GVAR(updateByEvent) isEqualTo _marker) exitWith {};

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance) max GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];
_nearPlayers = _nearPlayers select {[player, _x] call FUNC(canShare)};

// Send nearby players the updated marker's new position
[QGVAR(updateSingleMarkerEvent), [_marker, (markerPos _marker), player], _nearPlayers] call CBA_fnc_targetEvent;

[LLSTRING(SentMarkerUpdate), _nearPlayers] call FUNC(notifyList);

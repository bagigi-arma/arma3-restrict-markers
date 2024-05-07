#include "script_component.hpp"
/*
 * Handle the markerUpdated event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerUpdated
 */

params ["_marker", "_local"];

// Only handle stamped markers, meaning the code will only run when moving a local marker, as changing any marker attribute on the map will replace it with a completely new marker.
if !([_marker] call FUNC(isMarkerStamped)) exitWith {};

private _markerData = [_marker] call FUNC(serializeMarker);
GVAR(localMarkers) set [_marker, _markerData];

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];

// Send nearby players the updated marker's new data
[QGVAR(updateSingleMarkerEvent), [_marker, _markerData, player], _nearPlayers] call CBA_fnc_targetEvent;

["Sent updated marker position to:", _nearPlayers] call FUNC(notifyList);

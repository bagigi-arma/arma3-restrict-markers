#include "script_component.hpp"
/*
 * Share all of your markers with nearby players
 */

// Get nearby players within share distance (exclude local player)
private _nearPlayers = ([[ace_player, GVAR(shareDistance)]] call ace_map_gestures_fnc_getProximityPlayers) - [player];

[QGVAR(shareAllMarkersEvent), [GVAR(localMarkers), player], _nearPlayers] call CBA_fnc_targetEvent;

["Shared all markers with:", _nearPlayers] call FUNC(notifyList);

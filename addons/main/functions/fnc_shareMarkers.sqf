#include "script_component.hpp"
/*
 * Share markers with nearby players or copy theirs, depending on function arguments.
 */

params ["_mode", ["_target", ace_player]];

// Send markers to a single selected player
if (_mode == 4) exitWith {
	[QGVAR(shareAllMarkersEvent), [GVAR(localMarkers), player], _target] call CBA_fnc_targetEvent;
	["Shared all markers with:", [_target]] call FUNC(notifyList);
};
// Copy markers from a single selected player
if (_mode == 5) exitWith {
	[QGVAR(copyAllMarkersEvent), [player], _target] call CBA_fnc_targetEvent;
};

private _nearPlayers = [];

switch (_mode) do {
	case (0): { // All nearby players within share distance
		_nearPlayers = ([[ace_player, GVAR(shareDistance)]] call ace_map_gestures_fnc_getProximityPlayers);
	};
	case (1): { // All players in the same group within group share distance
		_nearPlayers = ([[ace_player, GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) arrayIntersect (units player);
	};
	case (2): { // All players within the same vehicle
		_nearPlayers = (crew vehicle player) select {alive _x};
	};
};

// Exclude local player
_nearPlayers = _nearPlayers - [player];

[QGVAR(shareAllMarkersEvent), [GVAR(localMarkers), player], _nearPlayers] call CBA_fnc_targetEvent;

["Shared all markers with:", _nearPlayers] call FUNC(notifyList);

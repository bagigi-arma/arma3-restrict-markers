#include "script_component.hpp"
/*
 * Returns an array of ACE Child Actions, to share your markers with any single nearby player.
 */

private _actions = [];

private _nearPlayers = ([[ace_player, (GVAR(shareDistance) max GVAR(shareDistanceGroup))]] call ace_map_gestures_fnc_getProximityPlayers) - [player];
{
	if ([player, _x] call FUNC(canShare)) then {
		private _action = [
			_x,
			name _x,
			"",
			{
				params ["_target", "_player", "_params"];
				[4, (_params select 0)] call FUNC(shareMarkers);
			},
			{true},
			{},
			[_x]
		] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _x];
	};
} forEach _nearPlayers;

_actions

#include "script_component.hpp"
/*
 * Share markers with nearby players or copy theirs, depending on function arguments.
 */

params ["_mode", ["_target", ace_player]];

// Send markers to a single selected player
if (_mode == 4) exitWith {
	[QGVAR(shareAllMarkersEvent), [GVAR(localMarkers), player], _target] call CBA_fnc_targetEvent;
	if (GVAR(showNotifications) >= NOTIFY_SHARE) then {
		[LLSTRING(SharedAllMarkersWith), [_target]] call FUNC(notifyList);
	};
};
// Copy markers from a single selected player
if (_mode == 5) exitWith {
	if (alive _target && {isPlayer _target}) then {
		[QGVAR(copyAllMarkersEvent), [player], _target] call CBA_fnc_targetEvent;
	} else {
		{
			[_x, _y] call FUNC(serializeMarker);
		} forEach (_target getVariable [QGVAR(localMarkers), []]);

		if (GVAR(showNotifications) >= NOTIFY_SHARE) then {
			[LLSTRING(ReceivedAllMarkers), [_target]] call FUNC(notifyList);
		};
	};
};

private _nearPlayers = [];

switch (_mode) do {
	case (0): { // All nearby players within share distance
		_nearPlayers = ([[ace_player, GVAR(shareDistance) max GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) select {[player, _x] call FUNC(canShare)};
	};
	case (1): { // All players in the same group within group share distance
		_nearPlayers = ([[ace_player, GVAR(shareDistanceGroup)]] call ace_map_gestures_fnc_getProximityPlayers) select {(group _x == group player) && ([player, _x] call FUNC(canShare))};
	};
	case (2): { // All players within the same vehicle (that are alive, conscious and not captives)
		_nearPlayers = (crew vehicle player) select {alive _x && {!captive _x} && {lifeState _x != "INCAPACITATED"}};
	};
};

// Exclude local player
_nearPlayers = _nearPlayers - [player];

[QGVAR(shareAllMarkersEvent), [GVAR(localMarkers), player], _nearPlayers] call CBA_fnc_targetEvent;

if (GVAR(showNotifications) >= NOTIFY_SHARE) then {
	[LLSTRING(SharedAllMarkersWith), _nearPlayers] call FUNC(notifyList);
};

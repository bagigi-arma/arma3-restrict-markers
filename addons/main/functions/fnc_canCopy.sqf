#include "script_component.hpp"
/*
 * Checks if a marker can be copied, when their owner is dead/unconscious or of the same faction (setting dependent).
 *
 * Arguments:
 * 0: Owner <UNIT> 
 */

params ["_owner"];

if (!GVAR(enabled)) exitWith {false};

private _standardCheck = {
	if (objectParent _owner == objectParent player) exitWith {true};
	private _distance = player distance _owner;
	if (group _owner == group player) exitWith {_distance <= GVAR(shareDistanceGroup)};
	_distance <= GVAR(shareDistance)
};

// If owner is dead/unconscious/captive, shortcut to distance/same vehicle check
if (!alive _owner || {lifeState _owner == "INCAPACITATED"} || {captive _owner}) exitWith {call _standardCheck};

// Determine whether markers can be copied from a different side
private _sideCopy = switch (GVAR(canCopyFromSide)) do {
	case (0): { // Nobody
		false
	};
	case (1): { // Only same Side
		(side group _owner) == (side group player)
	};
	case (2): { // Friendly Side
		[side group _owner, side group player] call BIS_fnc_sideIsFriendly
	};
	case (3): { // Any Side
		true
	};
};

_sideCopy && (call _standardCheck)

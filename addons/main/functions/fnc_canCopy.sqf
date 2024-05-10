#include "script_component.hpp"
/*
 * Checks if a marker can be copied, when their owner is dead/unconscious or of the same faction (setting dependent).
 *
 * Arguments:
 * 0: Owner <UNIT> 
 */

params ["_owner"];

if (!GVAR(enabled)) exitWith {false};

if (!alive _owner || {lifeState _owner == "INCAPACITATED"}) exitWith {true};

// Determine whether markers can be copied from a different side
switch (GVAR(canCopyFromSide)) do {
	case (0): { // Only same Side
		(side group _owner) == (side group player)
	};
	case (1): { // Friendly Side
		[side group _owner, side group player] call BIS_fnc_sideIsFriendly
	};
	case (2): { // Any Side
		true
	};
};

true

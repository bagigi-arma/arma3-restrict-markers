#include "script_component.hpp"
/*
 * Takes a message and array of nearby players and formats it as a list of arguments for CBA_fnc_notify, in order to print every element of the array on a new line.
 */

params ["_message", "_unitList"];

private _args = [[_message, 1.2]];

{
	_args pushBack [name _x];
} forEach _unitList;

_args call CBA_fnc_notify;

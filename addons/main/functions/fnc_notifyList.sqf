#include "script_component.hpp"
/*
 * Takes a message and array of nearby players and formats it as a list of arguments for CBA_fnc_notify, in order to print every element of the array on a new line.
 */

params ["_message", "_unitList", ["_skippable", true]];

// Do not print empty lists
if (_unitList isEqualTo []) exitWith {};

private _args = [[_message, 1.2]];

{
	_args pushBack [name _x];
} forEach _unitList;

// Skip or overwrite this notification if another entered the queue
_args pushBack _skippable;

_args call CBA_fnc_notify;

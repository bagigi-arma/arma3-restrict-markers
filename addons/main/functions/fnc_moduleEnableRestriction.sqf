#include "script_component.hpp"
/*
 * Launch the Restrict Markers zeus module to Enable the proximity restriction globally
 */

[
	_this,
	{
		params ["_posATL", "_attached", "_args"];
		[QGVAR(toggleRestriction), [true]] call CBA_fnc_globalEvent;
	}
] call FUNC(moduleToggleRestriction);

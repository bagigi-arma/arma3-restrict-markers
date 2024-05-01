#include "script_component.hpp"
/*
 * Launch the Restrict Markers zeus module to Disable the proximity restriction globally
 */

[
	_this,
	{
		params ["_posATL", "_attached", "_args"];
		[QGVAR(toggleRestriction), [false]] call CBA_fnc_globalEvent;
	}
] call FUNC(moduleToggleRestriction);

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

true

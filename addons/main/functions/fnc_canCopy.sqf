#include "script_component.hpp"
/*
 * Checks if a marker can be copied, when their owner is dead/unconscious or of the same faction (setting dependent).
 *
 * Arguments:
 * 0: Owner <UNIT> 
 */

params ["_owner"];

(player distance _owner <= GVAR(shareDistance) && alive player) || !GVAR(enabled)

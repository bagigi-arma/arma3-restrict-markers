#include "script_component.hpp"
/*
 * Checks if a marker can be shared, when the creator is within the share distance with the restriction enabled.
 *
 * Arguments:
 * 0: Owner <UNIT> 
 */

params ["_owner"];

(player distance _owner <= jib_marker_shareDistance && alive player) || !jib_marker_enabled
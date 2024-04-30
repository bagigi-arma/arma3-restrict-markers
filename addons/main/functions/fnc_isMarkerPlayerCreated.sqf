#include "script_component.hpp"
/*
 * Check if a marker is player created (ie not via a script)
 */

params ["_marker"];

_marker find "_USER_DEFINED" > -1

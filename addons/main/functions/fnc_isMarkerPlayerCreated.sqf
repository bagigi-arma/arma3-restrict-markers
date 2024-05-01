#include "script_component.hpp"
/*
 * Check if a marker is player created (ie not via a script)
 */

params ["_marker"];

"_USER_DEFINED" in _marker

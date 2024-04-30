#include "script_component.hpp"
/*
 * Check if a marker is stamped with the "magic tag", distinguishing it from non-player created markers.
 */

params ["_marker"];

_marker find jib_marker_magicTag > -1

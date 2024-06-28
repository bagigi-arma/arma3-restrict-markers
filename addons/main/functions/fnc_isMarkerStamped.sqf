#include "script_component.hpp"
/*
 * Check if a marker is stamped with the "magic tag", distinguishing it from global markers not (yet) processed by Restrict Markers.
 */

params ["_marker"];

MARKERTAG in _marker

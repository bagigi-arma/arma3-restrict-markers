#include "script_component.hpp"
/*
 * Discard a marker, deleting it locally
 */

params ["_marker"];

deleteMarkerLocal _marker;
GVAR(localMarkers) deleteAt _localMarker;

GVAR(syncMarkers) = true;

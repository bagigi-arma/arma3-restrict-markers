#include "script_component.hpp"
/*
 * Discard a marker, deleting it locally
 * 
 * NOTE: This function must be spawned to avoid a crash.
 */

params ["_marker"];

deleteMarkerLocal _marker;

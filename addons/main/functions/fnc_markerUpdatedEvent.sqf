#include "script_component.hpp"
/*
 * Handle the markerUpdated event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerUpdated
 */

params ["_marker", "_local"];

// Only handle stamped markers, meaning the code will only run when moving a local marker, as changing any marker attribute on the map will replace it with a completely new marker.
if !([_marker] call FUNC(isMarkerStamped)) exitWith {};

private _markerData = [_marker] call FUNC(serializeMarker);
GVAR(localMarkers) set [_marker, _markerData];

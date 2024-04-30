#include "script_component.hpp"
/*
 * Handle the markerCreated event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerCreated
 * 
 * The event fires for all created markers, including script created
 * and player created. When processing a player created marker, we
 * create a local marker which triggers this event recursively, so we
 * must detect that case and avoid infinite recursion.
 */

params ["_marker", "_channelNumber", "_owner", "_local"];

// If share enabled then revert to vanilla behavior
if (!jib_marker_enabled) exitWith {};

// Only process player created markers
if (![_marker] call FUNC(isMarkerPlayerCreated)) exitWith {};

// Break infinite loop
if ([_marker] call FUNC(isMarkerStamped)) exitWith {};

// Filter if marker can be shared
if (
	[_owner] call FUNC(canShare)
) then {
	// Process the marker
	[_marker, _owner] spawn FUNC(processMarker);
} else {
	// Discard the marker
	[_marker] spawn FUNC(discardMarker);
};

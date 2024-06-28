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

// If restriction is disabled, revert to vanilla behavior
if (!GVAR(enabled)) exitWith {};

// Only process player created markers
if !([_marker] call FUNC(isMarkerPlayerCreated)) exitWith {};

// Break infinite loop
if ([_marker] call FUNC(isMarkerStamped)) exitWith {};

// Filter if marker can be shared
if (
	(_local || {_owner getVariable [QGVAR(sharingEnabled), true]}) && 
	{isDedicated || ([_owner] call FUNC(canShare))}
) then {
	// Process the marker after 0.1s, to give the netcode time to sync all marker attributes before processing it to a local marker
	[FUNC(processMarker), [_marker, _owner], 0.1] call CBA_fnc_waitAndExecute;
} else {
	// Discard the marker
	[_marker] call FUNC(discardMarker);
};

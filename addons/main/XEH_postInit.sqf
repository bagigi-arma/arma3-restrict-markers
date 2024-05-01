#include "script_component.hpp"

#include "initSettings.inc.sqf"

[QGVAR(toggleRestriction), {
	params ["_enabled"];
	[QGVAR(enabled), GVAR(enabled), _enabled, "server"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

// Register the event handlers for processing markers
addMissionEventHandler [
	"MarkerCreated",
	FUNC(markerCreatedEvent)
];
addMissionEventHandler [
	"MarkerDeleted",
	FUNC(markerDeletedEvent)
];

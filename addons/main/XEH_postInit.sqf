#include "script_component.hpp"

#include "initSettings.inc.sqf"

[QGVAR(toggleRestriction), {
	params ["_enabled"];
	[QGVAR(enabled), _enabled, true, "mission"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

// Remove local stamped version of a marker deleted by a nearby player
[QGVAR(deleteStampedMarkerEvent), {
	params ["_marker", "_owner"];
	// Re-stamp with own client ID before deleting
	private _localMarker = [_marker] call FUNC(stampMarker);
	deleteMarkerLocal _localMarker;
	GVAR(localMarkers) deleteAt _localMarker;
	["Received deletion event from", [_owner]] call FUNC(notifyList);
}] call CBA_fnc_addEventHandler;

// Receive all local markers from a remote player and integrate them into ones own local markers
[QGVAR(shareAllMarkersEvent), {
	params ["_remoteMarkers", "_owner"]; // Hashmap containing all markers as serialized data
	{
		// Re-Stamp received marker
		private _key = [_x] call FUNC(stampMarker);
		private _value = _y;
		// Unserialize the received marker
		[_key, _value] call FUNC(serializeMarker);
	} forEach _remoteMarkers;
	["Received all markers from", [_owner]] call FUNC(notifyList);
}] call CBA_fnc_addEventHandler;

// Sends all of your markers to a remote player
[QGVAR(copyAllMarkersEvent), {
	params ["_target"];
	[4, _target] call FUNC(shareMarkers);
}] call CBA_fnc_addEventHandler;

// Register the event handlers for processing markers
addMissionEventHandler [
	"MarkerCreated",
	FUNC(markerCreatedEvent)
];
addMissionEventHandler [
	"MarkerDeleted",
	FUNC(markerDeletedEvent)
];
addMissionEventHandler [
	"MarkerUpdated",
	FUNC(markerUpdatedEvent)
];

GVAR(localMarkers) = createHashMap;

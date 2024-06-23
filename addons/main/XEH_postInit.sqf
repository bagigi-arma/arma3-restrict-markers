#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Remove local stamped version of a marker deleted by a nearby player
[QGVAR(deleteStampedMarkerEvent), {
	params ["_marker", "_owner"];
	// Abort if Auto-Deletion is disabled on the receiving client
	if (!GVAR(autoCopyDeletion)) exitWith {};
	// Re-stamp with own client ID before deleting
	private _localMarker = [_marker] call FUNC(stampMarker);
	GVAR(deletionByEvent) = _localMarker;
	deleteMarkerLocal _localMarker;
	GVAR(localMarkers) deleteAt _localMarker;
	[LLSTRING(ReceivedDeletionEvent), [_owner]] call FUNC(notifyList);
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
	[LLSTRING(ReceivedAllMarkers), [_owner]] call FUNC(notifyList);
}] call CBA_fnc_addEventHandler;

// Sends all of your markers to a remote player
[QGVAR(copyAllMarkersEvent), {
	params ["_target"];
	[4, _target] call FUNC(shareMarkers);
}] call CBA_fnc_addEventHandler;

// Receive a single marker data update after a nearby player moved it
[QGVAR(updateSingleMarkerEvent), {
	params ["_marker", "_markerPos", "_owner"];
	_marker = [_marker] call FUNC(stampMarker);
	GVAR(updateByEvent) = _marker;
	_marker setMarkerPosLocal _markerPos;
	GVAR(updateByEvent) = objNull;
	[LLSTRING(UpdateSingleMarker), [_owner]] call FUNC(notifyList);
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

// Status variables, to ignore certain marker update/delete events if they were triggered by a CBA Event
GVAR(deletionByEvent) = objNull;
GVAR(updateByEvent) = objNull;

// Public boolean attached to the player, retrievable globally to toggle sharing
GVAR(sharingEnabled) = true;
player setVariable [QGVAR(sharingEnabled), true, true];

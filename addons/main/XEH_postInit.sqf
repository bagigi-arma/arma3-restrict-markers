#include "script_component.hpp"

// Remove local stamped version of a marker deleted by a nearby player
[QGVAR(deleteStampedMarkerEvent), {
	params ["_marker", "_owner", ["_dedicatedOnly", false]];
	// Abort if Auto-Deletion is disabled on the receiving client
	if (!GVAR(autoCopyDeletion)) exitWith {};

	// Abort on clients if the event is only meant to propagate to the Dedicated Server
	if (_dedicatedOnly && !isDedicated) exitWith {};

	// Re-stamp with own client ID before deleting
	private _localMarker = [_marker] call FUNC(stampMarker);
	GVAR(deletionByEvent) = _localMarker;
	deleteMarkerLocal _localMarker;
	GVAR(localMarkers) deleteAt _localMarker;
	GVAR(syncMarkers) = true;

	if (GVAR(showNotifications) == NOTIFY_ALL) then {
		[LLSTRING(ReceivedDeletionEvent), [_owner]] call FUNC(notifyList);
	};
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

	if (GVAR(showNotifications) >= NOTIFY_SHARE) then {
		[LLSTRING(ReceivedAllMarkers), [_owner]] call FUNC(notifyList);
	};
}] call CBA_fnc_addEventHandler;

// Sends all of your markers to a remote player
[QGVAR(copyAllMarkersEvent), {
	params ["_target"];
	// Call share function with additional true argument, to suppress its notification
	[4, _target, true] call FUNC(shareMarkers);

	// Only notify if conscious
	if ((GVAR(showNotifications) >= NOTIFY_SHARE) && {lifeState player != "INCAPACITATED"}) then {
		[LLSTRING(MarkersCopiedBy), [_target]] call FUNC(notifyList);
	};
}] call CBA_fnc_addEventHandler;

// Receive a single marker data update after a nearby player moved it
[QGVAR(updateSingleMarkerEvent), {
	params ["_marker", "_markerPos", "_owner", ["_dedicatedOnly", false]];
	// Abort on clients if the event is only meant to propagate to the Dedicated Server
	if (_dedicatedOnly && !isDedicated) exitWith {};

	_marker = [_marker] call FUNC(stampMarker);
	GVAR(updateByEvent) = _marker;
	_marker setMarkerPosLocal _markerPos;
	GVAR(updateByEvent) = objNull;

	if (GVAR(showNotifications) == NOTIFY_ALL) then {
		[LLSTRING(UpdateSingleMarker), [_owner]] call FUNC(notifyList);
	};
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
player addMPEventHandler [
	"MPRespawn",
	FUNC(respawnEvent)
];

// GVAR and player object variables, to store ones own markers
GVAR(localMarkers) = createHashMap;
private _unitMarkers = player getVariable [QGVAR(localMarkers), []];
if !(_unitMarkers isEqualTo []) then {
	// import own markers from the unit the player joined as
	GVAR(localMarkers) = _unitMarkers;
	{
		[_x, _y] call FUNC(serializeMarker);
	} forEach _unitMarkers;
} else {
	player setVariable [QGVAR(localMarkers), +GVAR(localMarkers), true];
};

// Create a PFH that will sync localMarkers to your player object, as a backup for rejoining as the same unit
GVAR(syncMarkers) = false;
[{
	params ["_args", "_handle"];
	// Abort early if there are no new markers to sync or the player is currently dead (awaiting a respawn or end of mission)
	if (!GVAR(syncMarkers) || {!alive player}) exitWith {};

	player setVariable [QGVAR(localMarkers), +GVAR(localMarkers), true];
	GVAR(syncMarkers) = false;
}, 10] call CBA_fnc_addPerFrameHandler;

// Status variables, to ignore certain marker update/delete events if they were triggered by a CBA Event
GVAR(deletionByEvent) = objNull;
GVAR(updateByEvent) = objNull;

// Public boolean attached to the player, retrievable globally to toggle sharing
GVAR(sharingEnabled) = true;
player setVariable [QGVAR(sharingEnabled), true, true];

// Diary entry to explain Restrict Markers functionality and restrictions, if mod is enabled
if (GVAR(enabled)) then {
	player createDiarySubject [QUOTE(PREFIX), "Restrict Markers", QPATHTOF(data\interaction_icon.paa)];
	player createDiaryRecord [QUOTE(PREFIX), [LLSTRING(Diary_About_Title), LLSTRING(Diary_About_Text)]];
};

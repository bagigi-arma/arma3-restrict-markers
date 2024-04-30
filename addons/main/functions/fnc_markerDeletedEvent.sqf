#include "script_component.hpp"
/*
 * Handle the markerDeleted event
 * https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#MarkerDeleted
 */

params ["_marker", "_local"];

// Only handle stamped markers
if (![_marker] call FUNC(isMarkerStamped)) exitWith {};

// Broadcast to all clients.
//
// When a player deletes a stamped marker, the "markerDeleted"
// event doesn't fire on other clients because stamped markers
// are local. As a workaround, the client of the player deleting
// the stamped marker spawns a method on all client via
// `remoteExec`.
[player, _marker] remoteExec [QFUNC(stampedMarkerDeleted), 0, true];

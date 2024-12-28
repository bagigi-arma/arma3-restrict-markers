#include "script_component.hpp"
/*
 * Handle the MPRespawn event
 * https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#MPRespawn
 * 
 * The event fires when the unit it was assigned to respawns.
 * It handles marker persistence for the respawned player, as well as
 * adding of markers to the corpse, to allow copying by other alive units.
 */

params ["_unit", "_corpse"];

// Add markers to _corpse
_corpse setVariable [QGVAR(localMarkers), +GVAR(localMarkers), true];

if (GVAR(deleteMarkersOnRespawn)) then {
	// Delete all localMarkers and clear the HashMap
	{
		[_x] call FUNC(discardMarker);
	} forEach +GVAR(localMarkers);
	GVAR(localMarkers) = createHashMap;
};

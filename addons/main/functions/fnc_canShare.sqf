#include "script_component.hpp"
/*
 * Checks if a marker can be shared, when the creator is within the share distance with the restriction enabled.
 *
 * Arguments:
 * 0: Owner <UNIT> 
 */

params ["_owner", ["_recipient", player]];

if (!GVAR(enabled)) exitWith {true};

if (!alive _recipient || {lifeState _recipient == "INCAPACITATED"}) exitWith {false};

if (vehicle _owner == vehicle _recipient) exitWith {true};

private _distance = _recipient distance _owner;

if (group _owner == group _recipient) exitWith {_distance <= GVAR(shareDistanceGroup)};

_distance <= GVAR(shareDistance)

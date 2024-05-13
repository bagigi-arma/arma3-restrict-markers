#include "script_component.hpp"
/*
 * Toggles Marker Sharing, i.e: all marker propagation beyond the local map, and notifies the player of the setting's change.
 */

params ["_state"];

// Change Marker Sharing's state, both locally in a GVAR for quick lookup and globally via setVariable
GVAR(sharingEnabled) = _state;
player setVariable [QGVAR(sharingEnabled), _state, true];

// Notify the player of the new state
private _msg = LLSTRING(SharingOff);
if (_state) then {_msg = LLSTRING(SharingOn);};
[[_msg, 1.2], true] call CBA_fnc_notify;

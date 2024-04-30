#include "script_component.hpp"
/*
 * Validate module logic then run inner code.
 * 
 * Validation occurs on machine where logic is local.
 * Ensures activation and gets attached entity.
 * Inner code dispatched to specified machine. If inner code throws exception,
 * it dispatches display to machine where logic is local.
 * 
 * NOTE: Attributes of logic such as client owner may not be synced over network when inner code runs remotely.
 * More reliable to explicitly pass such attributes via args.
 */

params [
	"_moduleParams", // Module_F function params
	[
		"_code", // Run if validation success
		{
			params [
				"_posATL", // Logic position ATL
				"_attached", // Attached entity or objNull
				"_args" // Passed through extra args
			];
		},
		[{}]
	],
	["_args", [], [[]]], // Passed through to code
	["_locality", "server", [""]] // "server" or "local"
];
_moduleParams params ["_logic", "", "_isActivated"];

// Validate activation and locality
if (!_isActivated || {!local _logic}) exitWith {};

private _posATL = getPosATL _logic;

// Get synced entity
//
// NOTE: Only reliable on client where logic is local. Race
// condition to propagate variable from curator client to server.
private _attached = _logic getvariable ["bis_fnc_curatorAttachObject_object", objNull];

// Run inner code
switch (_locality) do {
	case "server": {
		[[clientOwner, _posATL, _attached, _code, _args], {
			params ["_client", "_posATL", "_attached", "_code", "_args"];
			try {[_posATL, _attached, _args] call _code} catch {
				[objNull, str _exception] remoteExec [
					"BIS_fnc_showCuratorFeedbackMessage",
					_client
				];
			};
		}] remoteExec ["spawn", 2];
	};
	case "local": {
		try {[_posATL, _attached, _args] call _code} catch {
			[
				objNull,
				str _exception
			] call BIS_fnc_showCuratorFeedbackMessage;
		};
	};
	default {};
};

deleteVehicle _logic;

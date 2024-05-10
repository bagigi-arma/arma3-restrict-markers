private _category = "Restrict Markers";

// Master switch to enable the mod.
[
	QGVAR(enabled),
	"CHECKBOX",
	[
		"Mod Enabled",
		"Determines whether the markers are restricted or function normally."
	],
	_category,
	true,
	1
] call CBA_fnc_addSetting;

// Distance within markers can be shared.
[
	QGVAR(shareDistance),
	"SLIDER",
	[
		"Marker Share Distance",
		"Maximum distance in meters to which created/updated markers are shared."
	],
	_category,
	[1, 30, 7, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
	1
] call CBA_fnc_addSetting;

// Distance within markers can be shared with your group.
[
	QGVAR(shareDistanceGroup),
	"SLIDER",
	[
		"Marker Group Share Distance",
		"Maximum distance in meters to which created/updated markers are shared with members of the same group."
	],
	_category,
	[1, 30, 7, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
	1
] call CBA_fnc_addSetting;

// Whether other players of different factions can copy your markers without your permission.
[
	QGVAR(canCopyFromSide),
	"LIST",
	[
		"Who can copy your markers",
		"Prevents copying of markers from conscious and non-captive players, for scenarios in which different factions might not be so open to map sharing."
	],
	_category,
	[ // [_values, _valueTitles, _defaultIndex]
		[0, 1, 2],
		["Only same Side", "Friendly Side(s)", "Any Side"],
		1
	],
	1
] call CBA_fnc_addSetting;

// Whether a nearby marker deletion is automatically propagated to oneself, client-setting
[
	QGVAR(autoCopyDeletion),
	"CHECKBOX",
	[
		"Copy Nearby Marker Deletion",
		"Choose whether you want a nearby marker deletion to also delete the marker on your map."
	],
	_category,
	true,
	2
] call CBA_fnc_addSetting;

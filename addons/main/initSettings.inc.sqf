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

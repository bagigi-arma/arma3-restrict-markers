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

// Distance restricted markers should share.
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

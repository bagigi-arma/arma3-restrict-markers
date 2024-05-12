private _category = "Restrict Markers";

// Master switch to enable the mod.
[
	QGVAR(enabled),
	"CHECKBOX",
	[LSTRING(ModuleSettings_Enabled_name), LSTRING(ModuleSettings_Enabled_description)],
	_category,
	true,
	1
] call CBA_fnc_addSetting;

// Distance within markers can be shared.
[
	QGVAR(shareDistance),
	"SLIDER",
	[LSTRING(ModuleSettings_ShareDistance_name), LSTRING(ModuleSettings_ShareDistance_description)],
	_category,
	[1, 30, 7, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
	1
] call CBA_fnc_addSetting;

// Distance within markers can be shared with your group.
[
	QGVAR(shareDistanceGroup),
	"SLIDER",
	[LSTRING(ModuleSettings_ShareDistanceGroup_name), LSTRING(ModuleSettings_ShareDistanceGroup_description)],
	_category,
	[1, 30, 7, 0], // [_min, _max, _default, _trailingDecimals, _isPercentage]
	1
] call CBA_fnc_addSetting;

// Whether other players of different factions can copy your markers without your permission.
[
	QGVAR(canCopyFromSide),
	"LIST",
	[LSTRING(ModuleSettings_CanCopyFromSide_name), LSTRING(ModuleSettings_CanCopyFromSide_description)],
	_category,
	[ // [_values, _valueTitles, _defaultIndex]
		[0, 1, 2, 3],
		[LSTRING(Nobody), LSTRING(OnlySameSide), LSTRING(FriendlySide), LSTRING(AnySide)],
		2
	],
	1
] call CBA_fnc_addSetting;

// Whether a nearby marker deletion is automatically propagated to oneself, client-setting
[
	QGVAR(autoCopyDeletion),
	"CHECKBOX",
	[LSTRING(ModuleSettings_AutoCopyDeletion_name), LSTRING(ModuleSettings_AutoCopyDeletion_description)],
	_category,
	true,
	2
] call CBA_fnc_addSetting;

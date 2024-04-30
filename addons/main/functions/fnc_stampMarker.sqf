#include "script_component.hpp"
/*
 * Stamp a marker string with owner ID and magic tag.
 * 
 * The owner ID is used to make each client's local marker unique,
 * and the magic tag is used to prevent inifinite recursion in the
 * event handlers. This function can be used to re-stamp a marker
 * with a different client ID.
 */

params ["_marker", "_ownerID"];

// Strip magic tag and owner ID (if any) to get base marker.
//
// Regex compiled every time. Hopefully won't impact performance
// noticeably. Will only occur when players interact with markers
// which shouldn't be too frequent.
private _baseMarker = _marker regexReplace [
	format [
		" %1 [0-9]+",
		MARKERTAG
	],
	""
];

// (Re)-Stamp marker with magic tag and specified owner ID
format [
	"%1 %2 %3",
	_baseMarker,
	MARKERTAG,
	_ownerID
]

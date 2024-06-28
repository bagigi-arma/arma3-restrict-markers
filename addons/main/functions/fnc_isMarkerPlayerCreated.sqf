#include "script_component.hpp"
/*
 * Check if a marker's name matches the format of a player created marker.
 * 
 * Markers placed on the map by a player have the format "_USER_DEFINED #<PlayerID>/<MarkerID>/<ChannelID>" (https://community.bistudio.com/wiki/allMapMarkers).
 * Only markers containing "_USER_DEFINED" can be edited by players, which is why many mission and mod scripts (i.e: Hearts&Minds, Turret Enhanced) use the same format for their markers.
 * For those markers to be treated differently by Restrict Markers, those mods should append a suffix to their marker names (i.e: " turretenhanced"). That way this function will NOT categorize them as player created.
 */

params ["_marker"];

_marker regexMatch "_USER_DEFINED #[0-9]+/[0-9]+/[0-9]+"

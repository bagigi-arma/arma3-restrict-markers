#include "script_component.hpp"
/*
 * Check if a marker was created by the given client, by matching the client's DirectPlay ID with the marker's PlayerID.
 */

params ["_marker", ["_client", player]];

_marker regexMatch (format ["_USER_DEFINED #%1/[0-9]+/[0-9]+(.*)", getPlayerID _client])

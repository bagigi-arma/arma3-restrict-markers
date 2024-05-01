if (!isServer) exitWith {};

// PRIVATE IMPLEMENTATION
//
// Everything below here is considered private.

// Magic tag for identifying processed markers
jib_marker_magicTag = "jib_marker_local";

// Publish variables and functions
publicVariable "jib_marker_enabled";
publicVariable "jib_marker_shareDistance";
publicVariable "jib_marker_magicTag";
publicVariable "jib_marker_stampMarker";
publicVariable "jib_marker_isMarkerStamped";
publicVariable "jib_marker_isMarkerPlayerCreated";
publicVariable "jib_marker_canShare";
publicVariable "jib_marker_processMarker";
publicVariable "jib_marker_discardMarker";
publicVariable "jib_marker_markerCreated";
publicVariable "jib_marker_stampedMarkerDeleted";
publicVariable "jib_marker_markerDeleted";
publicVariable "jib_marker_registerEventHandlers";
publicVariable "jib_marker_moduleValidate";

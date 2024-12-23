#define COMPONENT main
#define COMPONENT_BEAUTIFIED Main
#include "script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
	#define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "\z\ace\addons\main\script_macros.hpp"

// Magic tag for identifying processed markers
#define MARKERTAG "jib_marker_local"

// Notification Level Flags
#define NOTIFY_NONE 0
#define NOTIFY_SHARE 1
#define NOTIFY_ALL 2

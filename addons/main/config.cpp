#include "script_component.hpp"

class CfgPatches {
	class PREFIX {
		name = "Restrict Markers";
		author = "JibStyle";
		requiredVersion = 1.60;
		requiredAddons[] = {"A3_Modules_F"};
		units[] = {
			"jib_marker_moduleDisable",
			"jib_marker_moduleEnable",
		};
	};
};

class CfgFactionClasses {
	class NO_CATEGORY;
	class PREFIX: NO_CATEGORY {
		displayName = "Restrict Markers";
	};
};

class CBA_Extended_EventHandlers_base;
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

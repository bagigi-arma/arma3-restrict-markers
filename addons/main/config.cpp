#include "script_component.hpp"

class CfgPatches {
	class PREFIX {
		name = "Restrict Markers";
		author = "JibStyle";
		requiredVersion = 2.20;
		requiredAddons[] = {"A3_Modules_F","ace_common"};
		units[] = {
			QGVAR(moduleDisable),
			QGVAR(moduleEnable),
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

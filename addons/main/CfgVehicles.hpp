class CfgVehicles {
	// ACE Self-Interaction on map to re-share markers
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class JIB_ShareMarkers {
				displayName = "Share markers with nearby players";
				condition = QUOTE(visibleMap);
				statement = QUOTE(call FUNC(shareMarkers));
				exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
				showDisabled = 0;
			};
		};
	};

	// Zeus modules to enable/disable restriction globally
	class Module_F;
	class GVAR(module): Module_F {
		isGlobal = 1;
		curatorCanAttach = 1;
		category = QUOTE(PREFIX);
	};

	class GVAR(moduleDisable): GVAR(module) {
		scopeCurator = 2;
		displayName = "Disable Restrict Markers";
		function = QFUNC(moduleDisableRestriction);
	};
	class GVAR(moduleEnable): GVAR(module) {
		scopeCurator = 2;
		displayName = "Enable Restrict Markers";
		function = QFUNC(moduleEnableRestriction);
	};
};

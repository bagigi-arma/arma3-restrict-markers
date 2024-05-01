class CfgVehicles {
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

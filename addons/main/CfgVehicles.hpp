class CfgVehicles {
	class Module_F;
	class jib_marker_module: Module_F {
		isGlobal=1;
		curatorCanAttach=1;
		category = "jib_marker";
	};
	class jib_marker_moduleDisable: jib_marker_module {
		scopeCurator=2;
		displayName = "Disable Restrict Markers";
		function = "jib_marker_moduleDisable";
	};
	class jib_marker_moduleEnable: jib_marker_module {
		scopeCurator=2;
		displayName = "Enable Restrict Markers";
		function = "jib_marker_moduleEnable";
	};
};

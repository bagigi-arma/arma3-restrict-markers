class CfgPatches {
    class jib_marker {
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

class CfgFunctions {
    class jib_marker {
        class jib_marker {
            file = "x\jib_marker\addons\main";
            class marker { preInit = 1; recompile = 1; };
        };
    };
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class jib_marker: NO_CATEGORY { displayName = "Restrict Markers"; };
};

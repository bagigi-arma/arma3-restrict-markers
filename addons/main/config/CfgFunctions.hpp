class CfgFunctions {
    class JIB_RM {
        class Misc {
            file = "main\functions\Misc";
            requiredAddons[] = {"cba_settings"};

            class registerCBASettings {
                //recompile = 1; // debug
            };
            class registerEventHandlers {
                recompile = 1; // debug
                postInit = 1;
            };
            class markerCreated {
                recompile = 1; // debug
            };
            class markerUpdated {
                recompile = 1; // debug
            };
            class markerDeleted {
                recompile = 1; // debug
            };
            class shareMarker {
                recompile = 1; // debug
            };
        };
    };
};
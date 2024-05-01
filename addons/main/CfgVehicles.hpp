#define EXCEPTIONS exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"}

class CfgVehicles {
	// ACE Interactions to re-share or copy markers
	class Man;
	class CAManBase: Man {
		// Self-Interactions on Map
		class ACE_SelfActions {
			class JIB_Markers {
				displayName = CSTRING(ShareMarkers);
				condition = QUOTE(visibleMap);
				statement = "";
				EXCEPTIONS;
				showDisabled = 0;

				// Share markers with all players within share distance
				class JIB_MarkersShareLocal {
					displayName = CSTRING(ShareWithNearby);
					condition = QUOTE(true);
					statement = QUOTE([0] call FUNC(shareMarkers));
					EXCEPTIONS;
					showDisabled = 1;
				};
				// Share markers with a single player, selectable via child-interaction
				class JIB_MarkersShareSinglePlayer {
					displayName = CSTRING(ShareWithSingle);
					condition = QUOTE(true);
					statement = "";
					insertChildren = QUOTE(call FUNC(singleShareChildrenActions));
					EXCEPTIONS;
					showDisabled = 1;
				};
				// Share markers with every player in your group within "group share distance"
				class JIB_MarkersShareGroup {
					displayName = CSTRING(ShareWithGroup);
					condition = QUOTE(count units _player > 1);
					statement = QUOTE([1] call FUNC(shareMarkers));
					EXCEPTIONS;
					showDisabled = 1;
				};
				// Share markers with everyone inside your vehicle
				class JIB_MarkersShareVehicle {
					displayName = CSTRING(ShareWithVehicle);
					condition = QUOTE(vehicle _player != _player);
					statement = QUOTE([2] call FUNC(shareMarkers));
					EXCEPTIONS;
					showDisabled = 1;
				};
			};
		};

		// Interactions on player pelvis
		class ACE_Actions {
			class ACE_MainActions {
				class JIB_Markers {
					displayName = CSTRING(ShareMarkers);
					condition = QUOTE(true);
					statement = "";
					EXCEPTIONS;
					showDisabled = 0;

					// Share markers with targeted player
					class JIB_MarkersShare {
						displayName = CSTRING(ShareWithPlayer);
						condition = QUOTE([ARR_2(_player,_target)] call FUNC(canShare));
						statement = QUOTE([ARR_2(4,_target)] call FUNC(shareMarkers));
						EXCEPTIONS;
						showDisabled = 1;
					};
					// Copy markers from targeted player
					class JIB_MarkersClone {
						displayName = CSTRING(CopyFromPlayer);
						condition = QUOTE([_target] call FUNC(canCopy));
						statement = QUOTE([ARR_2(5,_target)] call FUNC(shareMarkers));
						EXCEPTIONS;
						showDisabled = 1;
					};
				};
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
		displayName = CSTRING(ModuleDisable_DisplayName);
		function = QFUNC(moduleDisableRestriction);
	};
	class GVAR(moduleEnable): GVAR(module) {
		scopeCurator = 2;
		displayName = CSTRING(ModuleEnable_DisplayName);
		function = QFUNC(moduleEnableRestriction);
	};
};

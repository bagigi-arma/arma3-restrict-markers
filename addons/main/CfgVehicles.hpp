#define ICON_MAIN icon = QPATHTOF(data\interaction_icon.paa)
#define ICON_SHARE icon = QPATHTOF(data\interaction_icon_share.paa)
#define ICON_COPY icon = QPATHTOF(data\interaction_icon_copy.paa)
#define EXCEPTIONS exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"}

class CfgVehicles {
	// ACE Interactions to re-share or copy markers
	class Man;
	class CAManBase: Man {
		// Self-Interactions on Map
		class ACE_SelfActions {
			class JIB_Markers {
				displayName = CSTRING(ShareMarkers);
				condition = QUOTE(visibleMap && GVAR(enabled));
				statement = "";
				ICON_MAIN;
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

				// Interactions to toggle automatic sharing of created/updated/deleted markers, as well as prevent copying
				class JIB_MarkersSharingOff {
					displayName = CSTRING(StopSharing);
					condition = QUOTE(GVAR(sharingEnabled));
					statement = QUOTE([false] call FUNC(toggleSharing));
					EXCEPTIONS;
					showDisabled = 1;
				};
				class JIB_MarkersSharingOn {
					displayName = CSTRING(StartSharing);
					condition = QUOTE(!GVAR(sharingEnabled));
					statement = QUOTE([true] call FUNC(toggleSharing));
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
					condition = QUOTE(GVAR(enabled));
					statement = "";
					ICON_MAIN;
					EXCEPTIONS;
					showDisabled = 0;

					// Share markers with targeted player
					class JIB_MarkersShare {
						displayName = CSTRING(ShareWithPlayer);
						condition = QUOTE(alive _target && [ARR_2(_player,_target)] call FUNC(canShare));
						statement = QUOTE([ARR_2(4,_target)] call FUNC(shareMarkers));
						ICON_SHARE;
						EXCEPTIONS;
						showDisabled = 1;
					};
					// Copy markers from targeted player
					class JIB_MarkersClone {
						displayName = CSTRING(CopyFromPlayer);
						condition = QUOTE([_target] call FUNC(canCopy));
						statement = QUOTE([ARR_2(5,_target)] call FUNC(shareMarkers));
						ICON_COPY;
						EXCEPTIONS;
						showDisabled = 1;
					};
				};
			};
		};
	};
};

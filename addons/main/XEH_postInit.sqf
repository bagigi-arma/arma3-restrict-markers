#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Register the event handlers for processing markers
addMissionEventHandler [
	"MarkerCreated",
	FUNC(markerCreatedEvent)
];
addMissionEventHandler [
	"MarkerDeleted",
	FUNC(markerDeletedEvent)
];

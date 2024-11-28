export type ConfigDefinition = {
	system: { SystemFn },
	middlewareSystems: { MiddlewareSystemFn },
	distancePrefix: string,
	highlightFade: boolean,
	fadeDistance: number,
	maxFadeDistance: number,
	permissions: {
		groups: {
			[number]: {
				{
					mode: "above" | "under" | "equals",
					rank: number,
				}
			},
		}?,
		players: {
			[number]: boolean,
		}?,
	}?,
}

export type WaypointMetadata = {
	color: Color3,
}

export type Waypoint = {
	name: string,
	group: string?,
	position: Vector3,
	highlights: { BasePart }?,
} & WaypointMetadata

export type APIFunctions = {
	getWaypoint: (id: string) -> Waypoint?,
	getWaypoints: (group: string) -> { [string]: Waypoint }?,
	hideAllWaypoints: () -> (),
	hideWaypoints: (ids: { string }) -> (),
	hideWaypointGroup: (group: string) -> (),
	showAllWaypoints: () -> (),
	showWaypoints: (ids: { string }) -> (),
	showWaypointGroup: (group: string) -> (),
	setAllEnabled: (enabled: boolean) -> (),
	setEnabled: (id: string, boolean: boolean) -> (),
	setWaypointGroupEnabled: (group: string, enabled: boolean) -> (),
	middleware: () -> boolean,
}

export type SystemFn = (localPlayer: Player, api: APIFunctions) -> ()
export type MiddlewareSystemFn = (
	localPlayer: Player,
	config: ConfigDefinition
) -> boolean

return nil

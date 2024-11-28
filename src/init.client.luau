local Players = game:GetService("Players")

local config = require(script.config)
local mount = require(script.utils.mount)
local types = require(script.types)
local ui = require(script.ui)
local vide = require(script.packages.vide)
local waypoints = require(script.waypoints)

local waypointsFolder = Instance.new("Folder")
waypointsFolder.Name = "waypoints"
waypointsFolder.Parent = workspace.Terrain

local enabledWaypoints: { [string]: vide.Source<boolean> } = {}

local function getWaypoint(id: string): types.Waypoint?
	return waypoints[id]
end

local function getWaypoints(group: string): { [string]: types.Waypoint }
	local filteredWaypoints = {}

	for id, waypoint in waypoints do
		if waypoint.group ~= group then
			continue
		end
		filteredWaypoints[id] = waypoint
	end

	return filteredWaypoints
end

local function setEnabled(id: string, enabled: boolean)
	assert(enabledWaypoints[id], `Unknown waypoint id {id}`)
	enabledWaypoints[id](enabled)
end

local function setAllEnabled(enabled: boolean)
	for _, enabledSource in enabledWaypoints do
		enabledSource(enabled)
	end
end

local function setWaypointGroupEnabled(group, enabled: boolean)
	for id, _ in getWaypoints(group) do
		setEnabled(id, enabled)
	end
end

local function hideAllWaypoints()
	setAllEnabled(false)
end

local function hideWaypoints(ids: { string })
	for _, id in ids do
		setEnabled(id, false)
	end
end

local function hideWaypointGroup(group: string)
	setWaypointGroupEnabled(group, false)
end

local function showAllWaypoints()
	setAllEnabled(true)
end

local function showWaypoints(ids: { string })
	for _, id in ids do
		setEnabled(id, true)
	end
end

local function showWaypointGroup(group: string)
	setWaypointGroupEnabled(group, true)
end

local function middleware(): boolean
	for _, middleware in config.middlewareSystems do
		if not middleware(Players.LocalPlayer, config) then
			return false
		end
	end

	return true
end

local apiFunctions = {
	getWaypoint = getWaypoint,
	getWaypoints = getWaypoints,
	hideAllWaypoints = hideAllWaypoints,
	hideWaypoints = hideWaypoints,
	hideWaypointGroup = hideWaypointGroup,
	showAllWaypoints = showAllWaypoints,
	showWaypoints = showWaypoints,
	showWaypointGroup = showWaypointGroup,
	setAllEnabled = setAllEnabled,
	setEnabled = setEnabled,
	setWaypointGroupEnabled = setWaypointGroupEnabled,
	middleware = middleware,
}

for _, system: types.SystemFn in config.system do
	system(Players.LocalPlayer, apiFunctions)
end

local function loadWaypoint(id: string, waypoint: types.Waypoint)
	local enabled = vide.source(false)
	mount(ui, waypointsFolder, waypoint, enabled)
	enabledWaypoints[id] = enabled
end

for id, waypoint in waypoints do
	loadWaypoint(id, waypoint)
end

setmetatable(waypoints, {
	__newindex = function(self, id, waypoint)
		loadWaypoint(id, waypoint)
		rawset(self, id, waypoint)
	end,
})

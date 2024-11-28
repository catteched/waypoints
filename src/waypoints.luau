local types = require(script.Parent.types)
local waypoint = require(script.Parent.utils.waypoint)

local waypoints = {} :: { [string]: types.Waypoint }

waypoint.FolderWaypoint(waypoints, workspace:WaitForChild("Waypoints"))

return waypoints

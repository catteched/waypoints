local chat = require(script.Parent.systems.chat)
local permissions = require(script.Parent.systems.permissions)
local types = require(script.Parent.types)

return {
	-- who should handle our showing/hiding waypoints
	-- you can also use a table to allow for multiple systems
	-- or you can just use the default chat system provided
	system = { chat },

	-- for systems to do like permission checking or whatever
	middlewareSystems = { permissions },

	-- the prefix for the distance shown for each waypoint
	-- e.g. if its "m", it'll show as 123m
	distancePrefix = " studs",

	-- if you want to make the highlights fade when you get closer/farther to the waypoint
	highlightFade = false,

	-- how far until the waypoint text fades
	fadeDistance = 25,

	-- how far until the waypoint condenses its information
	maxFadeDistance = 500,
} :: types.ConfigDefinition

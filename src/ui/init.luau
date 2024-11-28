local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local config = require(script.Parent.config)
local types = require(script.Parent.types)
local vide = require(script.Parent.packages.vide)

local localPlayer = Players.LocalPlayer

local function ui(
	waypoint: types.Waypoint,
	enabled: vide.Source<boolean>
): BillboardGui
	local distance = vide.source(0)

	local transparency = function()
		return if enabled() then 0.25 else 1
	end

	local labelTransparency = function()
		if not enabled() then
			return 1
		end

		if distance() >= config.maxFadeDistance then
			return 1
		end

		return if distance() >= config.fadeDistance
			then 0
			else 5 * math.log10(
				1 + ((config.fadeDistance - distance()) / config.fadeDistance)
			)
	end

	local circleTransparency = function()
		if not enabled() then
			return 1
		end
		return if distance() >= config.maxFadeDistance then 0 else 1
	end

	vide.cleanup(RunService.RenderStepped:Connect(function()
		distance(localPlayer:DistanceFromCharacter(waypoint.position))
	end))

	if waypoint.highlights then
		for _, highlightPart in waypoint.highlights do
			vide.create "BoxHandleAdornment" {
				Name = "Highlight",
				Parent = highlightPart,
				Adornee = highlightPart,
				Size = highlightPart.Size,
				Transparency = vide.spring(
					config.highlightFade and labelTransparency or transparency,
					0.5
				),
				Color3 = waypoint.color,
			}
		end
	end

	return vide.create "BillboardGui" {
		Name = waypoint.name,
		Size = UDim2.new(0, 500, 0, 50),
		AlwaysOnTop = true,
		ClipsDescendants = false,

		StudsOffsetWorldSpace = waypoint.position,

		vide.create "Frame" {
			Name = "Circle",
			Size = UDim2.fromScale(0.25, 0.25),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = waypoint.color,
			BackgroundTransparency = vide.spring(circleTransparency, 0.5),

			vide.create "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},

			vide.create "UIAspectRatioConstraint" {
				AspectRatio = 1,
			},
		},

		vide.create "CanvasGroup" {
			Name = "Body",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			GroupTransparency = vide.spring(labelTransparency, 0.5),

			vide.create "TextLabel" {
				Name = "Name",
				Size = UDim2.fromScale(1, 0.7),
				BackgroundTransparency = 1,

				Text = waypoint.name,
				TextScaled = true,
				TextColor3 = waypoint.color,
				TextStrokeTransparency = 0.8,

				FontFace = Font.fromName("Montserrat", Enum.FontWeight.Bold),
			},

			vide.create "TextLabel" {
				Name = "Distance",
				Size = UDim2.fromScale(1, 0.3),
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,

				Text = function()
					return `{math.floor(distance())}{config.distancePrefix}`
				end,
				TextScaled = true,
				TextColor3 = waypoint.color,
				TextStrokeTransparency = 0.8,

				FontFace = Font.fromName("Montserrat"),
			},
		},
	}
end

return ui

local types = require(script.Parent.Parent.types)

local function Waypoint(
	name: string,
	group: string?,
	positionOrPart: Vector3 | BasePart,
	highlights: { BasePart }?,
	metadata: types.WaypointMetadata
): types.Waypoint
	return {
		name = name,
		group = group,
		position = if typeof(positionOrPart) == "Instance"
			then positionOrPart.Position
			else positionOrPart,
		highlights = highlights,
		color = metadata.color,
	}
end

local function BasicWaypoint(
	name: string,
	color: Color3,
	positionOrPart: Vector3 | BasePart,
	highlights: { BasePart }?
): types.Waypoint
	return Waypoint(name, nil, positionOrPart, highlights, {
		color = color,
	})
end

local function GroupWaypoint(
	name: string,
	group: string,
	color: Color3,
	positionOrPart: Vector3 | BasePart,
	highlights: { BasePart }?
)
	return Waypoint(name, group, positionOrPart, highlights, {
		color = color,
	})
end

local function FolderWaypoint(
	waypoints: { [string]: types.Waypoint },
	folder: Folder
)
	local function loadPart(part: BasePart)
		local id = part:GetAttribute("Id") :: string?
		local group = part:GetAttribute("Group") :: string?
		local color = part.Color

		assert(id, `Missing id from {part:GetFullName()}`)

		local highlights = {}

		for _, instance in part:GetChildren() do
			if not instance:IsA("BasePart") then
				continue
			end
			table.insert(highlights, instance)
		end

		waypoints[id] = Waypoint(part.Name, group, part, highlights, {
			color = color,
		})
	end

	for _, instance in folder:GetChildren() do
		if instance:IsA("BasePart") then
			loadPart(instance)
		end
	end

	folder.ChildAdded:Connect(function(instance)
		if instance:IsA("BasePart") then
			loadPart(instance)
		end
	end)
end

return {
	BasicWaypoint = BasicWaypoint,
	GroupWaypoint = GroupWaypoint,
	FolderWaypoint = FolderWaypoint,
	Waypoint = Waypoint,
}

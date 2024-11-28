local types = require(script.Parent.Parent.types)

local permissionSystem: types.MiddlewareSystemFn = function(localPlayer, config)
	local permissions = config.permissions

	if not permissions then
		return true
	end

	if permissions.players then
		if permissions.players[localPlayer.UserId] then
			return true
		end
	end

	if permissions.groups then
		for groupId, groupPermissions in permissions.groups do
			local rank = localPlayer:GetRankInGroup(groupId)

			for _, groupPermission in groupPermissions do
				if
					(
						groupPermission.mode == "equals"
						and rank == groupPermission.rank
					)
					or (groupPermission.mode == "above" and rank > groupPermission.rank)
					or (
						groupPermission.mode == "under"
						and rank < groupPermission.rank
					)
				then
					return true
				end
			end
		end
	end

	return false
end

return permissionSystem

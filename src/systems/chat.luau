local TextChatService = game:GetService("TextChatService")

local types = require(script.Parent.Parent.types)

local chatSystem: types.SystemFn = function(_, api)
	TextChatService.OnIncomingMessage = function(message)
		if
			not api.middleware()
			or not message.Text:find("^/waypoints")
			or message.Status == Enum.TextChatMessageStatus.Sending
		then
			return
		end

		local parameter = message.Text:split(" ")[2]

		if parameter == "hide" then
			api.hideAllWaypoints()
			return
		end

		if parameter then
			api.hideAllWaypoints()
			api.showWaypointGroup(parameter)
		else
			api.showAllWaypoints()
		end
	end
end

return chatSystem

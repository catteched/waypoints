local vide = require(script.Parent.Parent.packages.vide)

local function mount<T...>(component: (T...) -> Instance, target: Instance, ...: T...)
	local args = table.pack(...)
	return vide.mount(function()
		return component(table.unpack(args :: any))
	end, target)
end

return mount

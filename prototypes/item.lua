local utility = require("utility")
local item = {}

function item.createItem(entity)
	local subgroup = utility.getSubgroup(entity)
	local icon = utility.getIconPath(entity)
	return
	{
		type = "item",
		name = entity.name,
		icon = icon,
		group = "additional_trains",
		subgroup = subgroup.name,
		order = subgroup.order,
		stack_size = 10,
		default_request_amount = 5,
		icon_size = 32,
		place_result = entity.name
	}
end

return item

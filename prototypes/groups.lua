local const = require("const")

local function getSubGroups()
    local groups = {}
    for key, vehicleType in pairs(const.VEHICLE_TYPE_SUBGROUPS) do
        for _, vehicleTypeSize in pairs(vehicleType) do
            local groupItem = {
                type = "item-subgroup",
                group = "additional_trains",
                --subgroup = key,
                order = vehicleTypeSize.order,
                name = vehicleTypeSize.name
            }
            table.insert(groups, groupItem)
        end
    end
    return groups
end

local subGroups = getSubGroups()
data:extend({ {
    type = "item-group",
    name = "additional_trains",
    icon = "__additional_trains__/graphics/icons/tech.png",
    icon_size = 64,
    inventory_order = "x",
    order = "e2"
} })
data:extend(subGroups)



-- local function getMainSubGroups()
--     local groups = { {
--         type = "item-subgroup",
--         group = "additional_trains",
--         order = "a",
--         name = "locomotives"
--     }, {
--         type = "item-subgroup",
--         group = "additional_trains",
--         order = "b",
--         name = "cargo-wagon"
--     }, {
--         type = "item-subgroup",
--         group = "additional_trains",
--         order = "c",
--         name = "fluid-wagon"
--     } }
--     return groups
-- end
--local groups = getMainSubGroups()
--data:extend(groups)
--data.raw["item"]["iron-plate"].subgroup = "locomotives-tiny"
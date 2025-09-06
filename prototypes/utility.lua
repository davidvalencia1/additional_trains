local const = require("const")
local utility = {}

function utility.copy(obj, seen)
    if type(obj) ~= 'table' then
        return obj
    end
    if seen and seen[obj] then
        return seen[obj]
    end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
        res[utility.copy(k, s)] = utility.copy(v, s)
    end
    return res
end

function utility.getSubgroup(entity)
    return const.VEHICLE_TYPE_SUBGROUPS[entity.type][entity.size]
end

function utility.getSubgroupName(entity)
    return const.VEHICLE_TYPE_SUBGROUPS[entity.type][entity.size].name
end

function utility.getPicturePath(entity, fileName)
    return "__additional_trains__/graphics/entity/" .. entity.type .. "/" .. entity.size .. "/" .. entity.name .. "/" ..
        fileName .. ".png";
end

function utility.getIconPath(entity)
    return "__additional_trains__/graphics/entity/" .. entity.type .. "/" .. entity.size .. "/" .. entity.name .. "/" ..
        "icon.png";
end

function utility.getMinimapRepresentation(type)
    local flags, size, scale = { "icon" }, { 20, 40 }, 0.5
    local filename = "__base__/graphics/entity/" .. type .. "/minimap-representation/" .. type ..
        "-minimap-representation.png"
    local selected_filename = "__base__/graphics/entity/" .. type .. "/minimap-representation/" .. type ..
        "-selected-minimap-representation.png"

    return {
        minimap = {
            flags = flags,
            size = size,
            scale = scale,
            filename = filename
        },
        selected_minimap = {
            flags = flags,
            size = size,
            scale = scale,
            filename = selected_filename
        }
    }
end

function utility.createPictureObject(entity)
    local pictures = {
        width = 256,
        height = 256,
        scale = 1,
        direction_count = entity.picture_count * entity.line_length * entity.lines_per_file,
        line_length = entity.line_length,
        lines_per_file = entity.lines_per_file,
        shift = entity.shift,
        back_equals_front = false,
        filenames = {}
    }
    if (entity.picture_width) then
        pictures.width = entity.picture_width
        pictures.height = entity.picture_height
    end
    if (entity.scale) then
        pictures.scale = entity.scale
    end
    if (entity.back_equals_front) then
        pictures.back_equals_front = entity.back_equals_front
    end

    for i = 1, entity.picture_count, 1 do
        pictures.filenames[i] = utility.getPicturePath(entity, i - 1)
    end
    return pictures
end

function utility.speedConversion(number)
    local speed = number / 216
    local digitPosition = -3
    local precision = 10 ^ digitPosition
    return math.floor(speed / precision) * precision
end

function utility.addDefaults(entity, defaults)
    local default = defaults[entity.size]
    if (default) then
        for k, v in pairs(default) do
            if (entity[k] == nil) then
                entity[k] = v
            end
        end
    end
end

return utility

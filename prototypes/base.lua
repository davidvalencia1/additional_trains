local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__base__.prototypes.factoriopedia-simulations")

local const = require("const")
local utility = require("utility")
local trainWheel = require("trainWheel")

local drive_over_tie = function()
    return {
        type = "play-sound",
        sound = {
            category = "environment",
            variations = sound_variations("__base__/sound/train-tie", 6, 0.4,
                { volume_multiplier("main-menu", 2.4), volume_multiplier("driving", 1.3) })
        }
    }
end

local rolling_stock_back_light = function()
    return
    {
        {
            minimum_darkness = 0.3,
            color = { 1, 0.1, 0.05, 0 },
            shift = { -0.6, 3.5 },
            size = 2,
            intensity = 0.6,
            add_perspective = true
        },
        {
            minimum_darkness = 0.3,
            color = { 1, 0.1, 0.05, 0 },
            shift = { 0.6, 3.5 },
            size = 2,
            intensity = 0.6,
            add_perspective = true
        }
    }
end

local rolling_stock_stand_by_light = function()
    return
    {
        {
            minimum_darkness = 0.3,
            color = { 0.05, 0.2, 1, 0 },
            shift = { -0.6, -3.5 },
            size = 2,
            intensity = 0.5,
            add_perspective = true
        },
        {
            minimum_darkness = 0.3,
            color = { 0.05, 0.2, 1, 0 },
            shift = { 0.6, -3.5 },
            size = 2,
            intensity = 0.5,
            add_perspective = true
        }
    }
end

local function createTrainBase(entity)
    local map = utility.getMinimapRepresentation(entity.type)
    local pictures = utility.createPictureObject(entity)

    return {
        name = entity.name,
        type = entity.type,
        icon = utility.getIconPath(entity),
        icon_size = 32,
        flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
        minable = {
            mining_time = 0.5,
            result = entity.name
        },
        -- mined_sound = {
        --     filename = "__core__/sound/deconstruct-medium.ogg"
        -- },
        mined_sound = sounds.deconstruct_large(0.8),
        energy_per_hit_point = 5,
        friction_force = 0.5,
        corpse = "medium-remnants",
        dying_explosion = "medium-explosion",
        damaged_trigger_effect = hit_effects.entity(),
        resistances = { {
            type = "fire",
            decrease = 15,
            percent = 50
        }, {
            type = "physical",
            decrease = 15,
            percent = 30
        }, {
            type = "impact",
            decrease = 50,
            percent = 60
        }, {
            type = "explosion",
            decrease = 15,
            percent = 30
        }, {
            type = "acid",
            decrease = 10,
            percent = 20
        } },
        pictures = {
            rotated = pictures
        },
        back_light = rolling_stock_back_light(),
        stand_by_light = rolling_stock_stand_by_light(),
        minimap_representation = map.minimap,
        selected_minimap_representation = map.selected_minimap,
        wheels = entity.wheels or trainWheel.noWheels,
        rail_category = "regular",
        drive_over_tie_trigger = drive_over_tie(),
        drive_over_tie_trigger_minimal_speed = 0.5,
        tie_distance = 50
    }
end

local base = {}

function base.createLocomotive(entity)
    local base = createTrainBase(entity)

    base.collision_box = entity.collision_box or { { -0.6, -2.6 }, { 0.6, 2.6 } }
    base.selection_box = entity.selection_box or { { -1, -3 }, { 1, 3 } }
    base.drawing_box = entity.drawing_box or { { -1, -4 }, { 1, 3 } }
    base.connection_distance = entity.connection_distance or 3
    base.joint_distance = entity.joint_distance or 4

    base.max_health = entity.max_health or 1000
    base.weight = entity.weight or 2000

    if (entity.max_speed) then
        base.max_speed = utility.speedConversion(entity.max_speed)
    else
        base.max_speed = 1.2
    end

    if entity.max_power then
        if type(entity.max_power) == "number" then
            base.max_power = entity.max_power .. "kW"
        else
            base.max_power = entity.max_power
        end
    else
        base.max_power = "600kW"
    end

    base.braking_force = entity.braking_force or 10

    base.reversing_power_modifier = entity.reversing_power_modifier or 0.6
    base.air_resistance = 0.0075
    base.vertical_selection_shift = -0.5

    base.energy_source = {
        type = "burner",
        fuel_categories = { "chemical" },
        effectivity = entity.effectivity or 1,
        fuel_inventory_size = entity.fuel_inventory_size or 3,
        smoke = { {
            name = "train-smoke",
            deviation = { 0.3, 0.3 },
            frequency = 100,
            position = { 0, 0 },
            starting_frame = 0,
            starting_frame_deviation = 60,
            height = 2,
            height_deviation = 0.5,
            starting_vertical_speed = 0.2,
            starting_vertical_speed_deviation = 0.1
        } }
    }
    base.front_light = { {
        type = "oriented",
        minimum_darkness = 0.3,
        picture = {
            filename = "__core__/graphics/light-cone.png",
            priority = "extra-high",
            flags = { "light" },
            scale = 2,
            width = 200,
            height = 200
        },
        shift = { -0.6, -16 },
        size = 2,
        intensity = entity.light_intensity or 0.6,
        color = { r = 1.0, g = 0.9, b = 0.9 }
    }, {
        type = "oriented",
        minimum_darkness = 0.3,
        picture = {
            filename = "__core__/graphics/light-cone.png",
            priority = "extra-high",
            flags = { "light" },
            scale = 2,
            width = 200,
            height = 200
        },
        shift = { 0.6, -16 },
        size = 2,
        intensity = entity.light_intensity or 0.6,
        color = { r = 1.0, g = 0.9, b = 0.9 }
    } }

    base.stop_trigger = { -- left side
        {
            type = "create-trivial-smoke",
            repeat_count = 125,
            smoke_name = "smoke-train-stop",
            initial_height = 0,
            -- smoke goes to the left
            speed = { -0.03, 0 },
            speed_multiplier = 0.75,
            speed_multiplier_deviation = 1.1,
            offset_deviation = { { -0.75, -2.7 }, { -0.3, 2.7 } }
        }, -- right side
        {
            type = "create-trivial-smoke",
            repeat_count = 125,
            smoke_name = "smoke-train-stop",
            initial_height = 0,
            -- smoke goes to the right
            speed = { 0.03, 0 },
            speed_multiplier = 0.75,
            speed_multiplier_deviation = 1.1,
            offset_deviation = { { 0.3, -2.7 }, { 0.75, 2.7 } }
        }, {
        type = "play-sound",
        sound = { {
            filename = "__base__/sound/train-breaks.ogg",
            volume = 0.6
        } }
    } }

    base.working_sound = {
        sound = {
            filename = "__base__/sound/train-engine.ogg",
            volume = 0.6
        },
        match_speed_to_activity = true
    }
    base.open_sound = {
        filename = "__base__/sound/car-door-open.ogg",
        volume = 0.7
    }
    base.close_sound = {
        filename = "__base__/sound/car-door-close.ogg",
        volume = 0.7
    }
    base.vehicle_impact_sound = {
        filename = "__base__/sound/car-metal-impact.ogg",
        volume = 0.65
    }
    return base
end

function base.createCargoWagon(entity)
    local base = createTrainBase(entity)

    base.collision_box = entity.collision_box or { { -0.6, -2.4 }, { 0.6, 2.4 } }
    base.selection_box = entity.selection_box or { { -1.0, -2.7 }, { 1, 3.3 } }
    base.connection_distance = entity.connection_distance or 3
    base.joint_distance = entity.joint_distance or 4

    base.inventory_size = entity.inventory_size or 40
    base.max_health = entity.max_health or 600
    base.weight = entity.weight or 1000

    if (entity.max_speed) then
        base.max_speed = utility.speedConversion(entity.max_speed)
    else
        base.max_speed = 1.5
    end

    base.braking_force = entity.braking_force or 3

    base.air_resistance = 0.01
    base.vertical_selection_shift = -0.8

    base.working_sound = {
        sound = {
            filename = "__base__/sound/train-wheels.ogg",
            volume = 0.5
        },
        match_volume_to_activity = true
    }
    base.open_sound = {
        filename = "__base__/sound/machine-open.ogg",
        volume = 0.85
    }
    base.close_sound = {
        filename = "__base__/sound/machine-close.ogg",
        volume = 0.75
    }

    base.crash_trigger = crash_trigger()
    base.vehicle_impact_sound = {
        filename = "__base__/sound/car-wood-impact.ogg",
        volume = 1.0
    }
    return base
end

function base.createFluidWagon(entity)
    local base = createTrainBase(entity)

    base.collision_box = entity.collision_box or { { -0.6, -2.4 }, { 0.6, 2.4 } }
    base.selection_box = entity.selection_box or { { -1, -2.7 }, { 1, 3.297 } }
    base.connection_distance = entity.connection_distance or 3
    base.joint_distance = entity.joint_distance or 4

    base.capacity = entity.capacity or 50000
    base.max_health = entity.max_health or 600
    base.weight = entity.weight or 1000

    if (entity.max_speed) then
        base.max_speed = utility.speedConversion(entity.max_speed)
    else
        base.max_speed = 1.5
    end

    base.braking_force = entity.braking_force or 3

    base.air_resistance = 0.01
    base.vertical_selection_shift = -0.8

    -- from railwaymod
    -- i don't see that these are actually used in the game, maybe it's a leftover from earlier versions
    --------------
    -- base.gui_front_tank = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/front-tank.png",
    --     width = 64,
    --     height = 64,
    --     flags = { "icon" }
    -- }
    -- base.gui_center_tank = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/center-tank.png",
    --     width = 64,
    --     height = 64,
    --     flags = { "icon" }
    -- }
    -- base.gui_back_tank = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/back-tank.png",
    --     width = 64,
    --     height = 64,
    --     flags = { "icon" }
    -- }
    -- base.gui_connect_front_center_tank = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/connector-front-center.png",
    --     width = 64,
    --     height = 64,
    --     flags = { "icon" }
    -- }
    -- base.gui_connect_center_back_tank = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/connector-center-back.png",
    --     width = 64,
    --     height = 64,
    --     flags = { "icon" }
    -- }
    -- base.gui_front_center_tank_indiciation = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/1.png",
    --     width = 32,
    --     height = 32,
    --     flags = { "icon" }
    -- }
    -- base.gui_center_back_tank_indiciation = {
    --     filename = "__base__/graphics/entity/fluid-wagon/gui/2.png",
    --     width = 32,
    --     height = 32,
    --     flags = { "icon" }
    -- }

    base.working_sound = {
        sound = {
            filename = "__base__/sound/train-wheels.ogg",
            volume = 0.5
        },
        match_volume_to_activity = true
    }
    base.crash_trigger = crash_trigger()
    base.vehicle_impact_sound = {
        filename = "__base__/sound/car-wood-impact.ogg",
        volume = 1.0
    }
    return base
end

return base

local base = require("base")
local recipe = require("recipe")
local const = require("const")
local item = require("item")
local trainWheel = require("trainWheel")
local utility = require("utility")

--[[
    locomotive = {
        name = "name",                          -- required
        size = const.VEHICLE_SIZE.TINY,         -- required
        type = const.VEHICLE_TYPE.LOCOMOTIVE,   -- required

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },   -- optional
        selection_box = { { -0.7, -1.6 }, { 1, 1.2 } },     -- optional
        drawing_box = { { -1, -1 }, { 1, 1 } },             -- optional

        max_health = 1000,      -- optional
        weight = 2000,          -- optional
        max_speed = 120,        -- optional
        max_power = 500,        -- optional
        braking_force = 10,     -- optional

        effectivity = 1.0,          -- optional fuel efficiency, higher number = more efficient
        fuel_inventory_size = 3,    -- optional

        connection_distance = 3.0,  -- optional
        joint_distance = 4.0,       -- optional

        picture_count = 2,          -- required
        picture_width = 256,        -- optional
        picture_height = 256,       -- optional
        scale = 1,                  -- optional
        line_length = 8,            -- required
        lines_per_file = 8,         -- required
        shift = { 0.42, -1.125 }    -- required
    }
]]

local locomotiveDefaults = {
    [const.VEHICLE_SIZE.TINY] = {
        weight              = settings.startup["locomotive_tiny_weight"].value,
        max_speed           = settings.startup["locomotive_tiny_max_speed"].value,
        max_power           = settings.startup["locomotive_tiny_max_power"].value,
        light_intensity     = settings.startup["locomotive_tiny_light_intensity"].value,
        effectivity         = 1.1,
        fuel_inventory_size = 1,
    },
    [const.VEHICLE_SIZE.SMALL] = {
        weight              = settings.startup["locomotive_small_weight"].value,
        max_speed           = settings.startup["locomotive_small_max_speed"].value,
        max_power           = settings.startup["locomotive_small_max_power"].value,
        light_intensity     = settings.startup["locomotive_small_light_intensity"].value,
        effectivity         = 1.0,
        fuel_inventory_size = 2,
    },
    [const.VEHICLE_SIZE.NORMAL] = {
        weight              = settings.startup["locomotive_normal_weight"].value,
        max_speed           = settings.startup["locomotive_normal_max_speed"].value,
        max_power           = settings.startup["locomotive_normal_max_power"].value,
        light_intensity     = settings.startup["locomotive_normal_light_intensity"].value,
        effectivity         = 1.0,
        fuel_inventory_size = 3,
    },
}

local locomotivesTiny = {
    {
        name = "y_loco_usl_gray",
        size = const.VEHICLE_SIZE.TINY,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -1.6 }, { 1, 1.2 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 2.2,
        joint_distance = 1.1,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        scale = 1,
        shift = { 0, -0.625 }
    },
    {
        name = "y_loco_usl",
        size = const.VEHICLE_SIZE.TINY,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -1.6 }, { 1, 1.2 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 2.2,
        joint_distance = 1.1,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        scale = 1,
        shift = { 0, -0.625 }
    }
}

local locomotivesSmall = {
    {
        name = "y_loco_desw_blue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.5,
        joint_distance = 1.3,

        picture_count = 8,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
    },
    {
        name = "y_loco_desw_green",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 8,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },

    },
    {
        name = "y_loco_desw_orange",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.5,
        joint_distance = 1.3,

        picture_count = 8,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
    },
    {
        name = "y_loco_ses_std",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 8,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },

    },
    {
        name = "y_loco_ses_red",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 8,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
    },
    {
        name = "y_loco_emd1500black",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emd1500gray",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emd1500blue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emd1500lightblue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emd1500lightgreen",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_fesw",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        collision_box = { { -0.6, -1.1 }, { 0.6, 1.1 } },
        selection_box = { { -0.85, -1.5 }, { 0.9, 1.5 } },
        drawing_box = { { -1, -1 }, { 1, 1 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    }
}

local locomotivesNormal = {
    {
        name = "y_loco_emd2r_gray",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "y_loco_wt717_orange",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 },
    },
    {
        name = "y_loco_wt717_white",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 },
    },
    {
        name = "y_loco_wt450_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 },

    },
    {
        name = "y_loco_wt580_orange",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 },
    },
    {
        name = "y_loco_es44_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.4, -1.125 }

    },
    {
        name = "y_loco_lsw_840_green",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
    },
    {
        name = "y_loco_lsw_790_orange",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_lsw_790_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emdf7_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.2, -1.125 }
    },
    {
        name = "y_loco_emdf7_light",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.2, -1.125 }
    },
    {
        name = "y_loco_emdf7_dark",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.2, -1.125 }
    },
    {
        name = "y_loco_zepyr_brown",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -0.625 }
    },
    {
        name = "y_loco_emd2900_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_emd3000_white",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_kr05_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_brown",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_gold",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_green",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr05_ultraviolet",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_kr09_lightblue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_ns2200_brown",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_ns2200_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_ns2200_white",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_ns2200_yellow",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 8,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 }
    },
    {
        name = "y_loco_sel351_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    },
    {
        name = "y_loco_mre044_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.LOCOMOTIVE,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 }
    }
}

local function addLocomotive(entity)
    utility.addDefaults(entity, locomotiveDefaults)
    local locomotive = base.createLocomotive(entity)
    local createdRecipe = recipe.createRecipe(entity)
    local createdItem = item.createItem(entity)

    data:extend({ createdRecipe })
    data:extend({ createdItem })
    data:extend({ locomotive })
end

local function addLocomotives(locomotives)
    for _, loco in pairs(locomotives) do
        addLocomotive(loco)
    end
end

local function changeStandardLocomotive()
    data.raw["locomotive"]["locomotive"].weight = locomotiveDefaults[const.VEHICLE_SIZE.NORMAL].weight
    data.raw["locomotive"]["locomotive"].max_speed = utility.speedConversion(locomotiveDefaults
        [const.VEHICLE_SIZE.NORMAL].max_speed)
    data.raw["locomotive"]["locomotive"].max_power = locomotiveDefaults[const.VEHICLE_SIZE.NORMAL].max_power .. "kW"

    data.raw["locomotive"]["locomotive"].front_light[1].intensity = locomotiveDefaults[const.VEHICLE_SIZE.NORMAL]
        .light_intensity
    data.raw["locomotive"]["locomotive"].front_light[2].intensity = locomotiveDefaults[const.VEHICLE_SIZE.NORMAL]
        .light_intensity
end

addLocomotives(locomotivesTiny)
addLocomotives(locomotivesSmall)
addLocomotives(locomotivesNormal)

changeStandardLocomotive()

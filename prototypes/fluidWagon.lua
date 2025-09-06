local base = require("base")
local recipe = require("recipe")
local const = require("const")
local item = require("item")
local trainWheel = require("trainWheel")
local utility = require("utility")

--[[
    cargo = {
        name = "name",                          -- required
        size = const.VEHICLE_SIZE.TINY,         -- required
        type = const.VEHICLE_TYPE.FLUID_WAGON,   -- required

        collision_box = { { -0.6, -2.4 }, { 0.6, 2.4 } },   -- optional
        selection_box = { { -1, -2.7 }, { 1, 3.297 } },     -- optional
        drawing_box = { { -1, -1 }, { 1, 1 } },             -- optional

        capacity = 50000,       -- optional
        max_health = 600,       -- optional
        weight = 1000,          -- optional
        max_speed = 324,        -- optional
        braking_force = 3,      -- optional

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

local fluidDefaults = {
    -- not yet implemented
    -- [const.VEHICLE_SIZE.TINY] = {
    --     capacity      = 12500,
    --     max_health    = 300,
    --     weight        = 500,
    --     max_speed     = 140,
    --     braking_force = 2,
    -- },
    [const.VEHICLE_SIZE.SMALL] = {
        capacity      = settings.startup["fluidwagon_small_capacity"].value,
        max_health    = settings.startup["fluidwagon_small_max_health"].value,
        weight        = settings.startup["fluidwagon_small_weight"].value,
        max_speed     = settings.startup["fluidwagon_small_max_speed"].value,
        braking_force = 2,
    },
    [const.VEHICLE_SIZE.NORMAL] = {
        capacity      = settings.startup["fluidwagon_normal_capacity"].value,
        max_health    = settings.startup["fluidwagon_normal_max_health"].value,
        weight        = settings.startup["fluidwagon_normal_weight"].value,
        max_speed     = settings.startup["fluidwagon_normal_max_speed"].value,
        braking_force = 3,
    },
}

-- not yet implemented
-- local fluidWagonsTiny = {
--     {
--         name = "<name>",
--         size = const.VEHICLE_SIZE.TINY,
--         type = const.VEHICLE_TYPE.FLUID_WAGON,

--         picture_count = 1,
--         line_length = 8,
--         lines_per_file = 8,
--         shift = { 0.42, -1.125 },
--         back_equals_front = true
--     },
-- }

local fluidWagonsSmall = {
    {
        name = "fw_s_s1_orange",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false
    },
    {
        name = "fw_s_s1_stripe_blue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false
    },
    {
        name = "fw_s_cement_gray",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "fw_s_cement_white",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    }
}

local fluidWagonsNormal = {
    {
        name = "fw_n_acid_orange",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_acid_stripe_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_acid_stripe_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_fatmice",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "fw_n_rd",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "fw_n_tk",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_brown",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_gold",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_green",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "fw_n_kr_ultraviolet",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.FLUID_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -0.875 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
}

local function addFluid(entity)
    utility.addDefaults(entity, fluidDefaults)
    local fluidWagon = base.createFluidWagon(entity)
    local createdRecipe = recipe.createRecipe(entity)
    local createdItem = item.createItem(entity)

    data:extend({ createdRecipe })
    data:extend({ createdItem })
    data:extend({ fluidWagon })
end

local function addFluidWagons(fluidWagons)
    for _, wagon in pairs(fluidWagons) do
        addFluid(wagon)
    end
end

local function changeStandardFluidWagon()
    data.raw["fluid-wagon"]["fluid-wagon"].capacity = fluidDefaults[const.VEHICLE_SIZE.NORMAL].capacity
    data.raw["fluid-wagon"]["fluid-wagon"].max_health = fluidDefaults[const.VEHICLE_SIZE.NORMAL].max_health
    data.raw["fluid-wagon"]["fluid-wagon"].weight = fluidDefaults[const.VEHICLE_SIZE.NORMAL].weight
    data.raw["fluid-wagon"]["fluid-wagon"].max_speed = utility.speedConversion(fluidDefaults[const.VEHICLE_SIZE.NORMAL]
        .max_speed)
end

addFluidWagons(fluidWagonsSmall)
addFluidWagons(fluidWagonsNormal)

changeStandardFluidWagon()

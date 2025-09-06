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
        type = const.VEHICLE_TYPE.CARGO_WAGON,   -- required

        collision_box = { { -0.6, -2.4 }, { 0.6, 2.4 } },   -- optional
        selection_box = { { -1.0, -2.7 }, { 1, 3.3 } },     -- optional
        drawing_box = { { -1, -1 }, { 1, 1 } },             -- optional

        inventory_size = 40,    -- optional
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

local cargoDefaults = {
    [const.VEHICLE_SIZE.TINY] = {
        inventory_size = settings.startup["cargowagon_tiny_inventory_size"].value,
        max_health     = settings.startup["cargowagon_tiny_max_health"].value,
        weight         = settings.startup["cargowagon_tiny_weight"].value,
        max_speed      = settings.startup["cargowagon_tiny_max_speed"].value,
        braking_force  = 2,
    },
    [const.VEHICLE_SIZE.SMALL] = {
        inventory_size = settings.startup["cargowagon_small_inventory_size"].value,
        max_health     = settings.startup["cargowagon_small_max_health"].value,
        weight         = settings.startup["cargowagon_small_weight"].value,
        max_speed      = settings.startup["cargowagon_small_max_speed"].value,
        braking_force  = 2,
    },
    [const.VEHICLE_SIZE.NORMAL] = {
        inventory_size = settings.startup["cargowagon_normal_inventory_size"].value,
        max_health     = settings.startup["cargowagon_normal_max_health"].value,
        weight         = settings.startup["cargowagon_normal_weight"].value,
        max_speed      = settings.startup["cargowagon_normal_max_speed"].value,
        braking_force  = 3,
    },
}

local cargoWagonsTiny = {
    {
        name = "cw_t_cr_black",
        size = const.VEHICLE_SIZE.TINY,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -1.6 }, { 1, 1.2 } },

        connection_distance = 2.2,
        joint_distance = 1.1,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0, -0.625 },
        back_equals_front = true,

        horizontal_doors =
        {
            layers =
            {
                {
                    filename = "__additional_trains__/graphics/entity/cargo-wagon/tiny/cw_cr_black/usw_we.png",
                    line_length = 1,
                    width = 256,
                    height = 256,
                    frame_count = 1,
                    shift = { 0, -0.625 },
                }
            }
        },
        vertical_doors =
        {
            layers =
            {
                {
                    filename = "__additional_trains__/graphics/entity/cargo-wagon/tiny/cw_cr_black/usw_ns.png",
                    line_length = 1,
                    width = 256,
                    height = 256,
                    frame_count = 1,
                    shift = { 0, -0.625 },
                }
            }
        },

    },
}

local cargoWagonsSmall = {
    {
        name = "cw_s_as1_blue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_as1_green",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_box",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 4,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_cr",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_hooper",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_hooper_gray",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_open_coal",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 4,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_open_copper",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 4,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_open_iron",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 4,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_open_stone",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 4,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_rh_corn",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_rh_red_blue",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_tender_black",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -2.5 }, { 0.6, 2.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 2.2 } },

        connection_distance = 3,
        joint_distance = 2.5,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_tender_green",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -2.5 }, { 0.6, 2.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 2.2 } },

        connection_distance = 3,
        joint_distance = 2.5,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_s_tf",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_v",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_s_wood",
        size = const.VEHICLE_SIZE.SMALL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        collision_box = { { -0.6, -1.5 }, { 0.6, 1.1 } },
        selection_box = { { -0.7, -2.6 }, { 1, 1.2 } },

        connection_distance = 3.6,
        joint_distance = 1.8,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
}

local cargoWagonsNormal = {
    {
        name = "cw_n_b1_purple",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_blocks",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_box",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_c2_box",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 4,
        picture_width = 512,
        picture_height = 512,
        scale = 0.5,
        line_length = 4,
        lines_per_file = 4,
        shift = { 0, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },
    {
        name = "cw_n_cr",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_cr_container",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
        {
        name = "cw_n_kr",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_kr_vc_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_brown",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_gold",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_green",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_red",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_kr_vc_ultraviolet",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

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
        name = "cw_n_l1_steel",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_m1_gray",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_m1_rust",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_mai_plate",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_ocean_blue",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_ocean_gray",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_open_coal",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_open_copper",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_open_iron",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_open_stone",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_rm_gold",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_rm_gray",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_us_black",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_us_dark",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_us_white",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 2,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = false,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_wood",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.noWheels,
    },
    {
        name = "cw_n_woodbox",
        size = const.VEHICLE_SIZE.NORMAL,
        type = const.VEHICLE_TYPE.CARGO_WAGON,

        picture_count = 1,
        line_length = 8,
        lines_per_file = 8,
        shift = { 0.42, -1.125 },
        back_equals_front = true,

        wheels = trainWheel.standardTrainWheels,
    },



}

local function addCargo(entity)
    utility.addDefaults(entity, cargoDefaults)
    local cargoWagon = base.createCargoWagon(entity)
    local createdRecipe = recipe.createRecipe(entity)
    local createdItem = item.createItem(entity)

    data:extend({ createdRecipe })
    data:extend({ createdItem })
    data:extend({ cargoWagon })
end

local function addCargoWagons(cargoWagons)
    for _, wagon in pairs(cargoWagons) do
        addCargo(wagon)
    end
end

local function changeStandardCargoWagon()
    data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = cargoDefaults[const.VEHICLE_SIZE.NORMAL].inventory_size
    data.raw["cargo-wagon"]["cargo-wagon"].max_health = cargoDefaults[const.VEHICLE_SIZE.NORMAL].max_health
    data.raw["cargo-wagon"]["cargo-wagon"].weight = cargoDefaults[const.VEHICLE_SIZE.NORMAL].weight
    data.raw["cargo-wagon"]["cargo-wagon"].max_speed = utility.speedConversion(cargoDefaults[const.VEHICLE_SIZE.NORMAL]
        .max_speed)
end

addCargoWagons(cargoWagonsTiny)
addCargoWagons(cargoWagonsSmall)
addCargoWagons(cargoWagonsNormal)

changeStandardCargoWagon()

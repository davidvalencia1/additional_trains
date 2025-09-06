data:extend({
    -- Locomotive tiny settings
    {
        type = "int-setting",
        name = "locomotive_tiny_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 80,
        maximum_value = 500,
        localised_name = { "setting-name.locomotive_tiny_max_speed" },
        localised_description = { "setting-description.locomotive_tiny_max_speed" },
        order = "a01"
    },
    {
        type = "int-setting",
        name = "locomotive_tiny_max_power",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 200,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_tiny_max_power" },
        localised_description = { "setting-description.locomotive_tiny_max_power" },
        order = "a02"
    },
    {
        type = "int-setting",
        name = "locomotive_tiny_weight",
        setting_type = "startup",
        minimum_value = 100,
        default_value = 750,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_tiny_weight" },
        localised_description = { "setting-description.locomotive_tiny_weight" },
        order = "a03"
    },
    -- Locomotive small settings
    {
        type = "int-setting",
        name = "locomotive_small_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 130,
        maximum_value = 500,
        localised_name = { "setting-name.locomotive_small_max_speed" },
        localised_description = { "setting-description.locomotive_small_max_speed" },
        order = "a04"
    },
    {
        type = "int-setting",
        name = "locomotive_small_max_power",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 450,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_small_max_power" },
        localised_description = { "setting-description.locomotive_small_max_power" },
        order = "a05"
    },
    {
        type = "int-setting",
        name = "locomotive_small_weight",
        setting_type = "startup",
        minimum_value = 100,
        default_value = 1250,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_small_weight" },
        localised_description = { "setting-description.locomotive_small_weight" },
        order = "a06"
    },
    -- Locomotive normal settings
    {
        type = "int-setting",
        name = "locomotive_normal_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 180,
        maximum_value = 500,
        localised_name = { "setting-name.locomotive_normal_max_speed" },
        localised_description = { "setting-description.locomotive_normal_max_speed" },
        order = "a07"
    },
    {
        type = "int-setting",
        name = "locomotive_normal_max_power",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 1100,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_normal_max_power" },
        localised_description = { "setting-description.locomotive_normal_max_power" },
        order = "a08"
    },
    {
        type = "int-setting",
        name = "locomotive_normal_weight",
        setting_type = "startup",
        minimum_value = 100,
        default_value = 2000,
        maximum_value = 10000,
        localised_name = { "setting-name.locomotive_normal_weight" },
        localised_description = { "setting-description.locomotive_normal_weight" },
        order = "a09"
    },
    -- Light intensity
    {
        type = "double-setting",
        name = "locomotive_tiny_light_intensity",
        setting_type = "startup",
        minimum_value = 0.1,
        default_value = 0.3,
        maximum_value = 1.0,
        localised_name = { "setting-name.locomotive_tiny_light_intensity" },
        localised_description = { "setting-description.locomotive_tiny_light_intensity" },
        order = "a10"
    },
    {
        type = "double-setting",
        name = "locomotive_small_light_intensity",
        setting_type = "startup",
        minimum_value = 0.1,
        default_value = 0.6,
        maximum_value = 1.0,
        localised_name = { "setting-name.locomotive_small_light_intensity" },
        localised_description = { "setting-description.locomotive_small_light_intensity" },
        order = "a11"
    },
    {
        type = "double-setting",
        name = "locomotive_normal_light_intensity",
        setting_type = "startup",
        minimum_value = 0.1,
        default_value = 0.9,
        maximum_value = 1.0,
        localised_name = { "setting-name.locomotive_normal_light_intensity" },
        localised_description = { "setting-description.locomotive_normal_light_intensity" },
        order = "a12"
    },
    -- Cargo wagon tiny settings
    {
        type = "int-setting",
        name = "cargowagon_tiny_inventory_size",
        setting_type = "startup",
        minimum_value = 1,
        default_value = 15,
        maximum_value = 100,
        localised_name = { "setting-name.cargowagon_tiny_inventory_size" },
        localised_description = { "setting-description.cargowagon_tiny_inventory_size" },
        order = "b01"
    },
    {
        type = "int-setting",
        name = "cargowagon_tiny_max_health",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 300,
        maximum_value = 1000,
        localised_name = { "setting-name.cargowagon_tiny_max_health" },
        localised_description = { "setting-description.cargowagon_tiny_max_health" },
        order = "b02"
    },
    {
        type = "int-setting",
        name = "cargowagon_tiny_weight",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 500,
        maximum_value = 10000,
        localised_name = { "setting-name.cargowagon_tiny_weight" },
        localised_description = { "setting-description.cargowagon_tiny_weight" },
        order = "b03"
    },
    {
        type = "int-setting",
        name = "cargowagon_tiny_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 140,
        maximum_value = 500,
        localised_name = { "setting-name.cargowagon_tiny_max_speed" },
        localised_description = { "setting-description.cargowagon_tiny_max_speed" },
        order = "b04"
    },
    -- Cargo wagon small settings
    {
        type = "int-setting",
        name = "cargowagon_small_inventory_size",
        setting_type = "startup",
        minimum_value = 1,
        default_value = 25,
        maximum_value = 100,
        localised_name = { "setting-name.cargowagon_small_inventory_size" },
        localised_description = { "setting-description.cargowagon_small_inventory_size" },
        order = "b05"
    },
    {
        type = "int-setting",
        name = "cargowagon_small_max_health",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 450,
        maximum_value = 1000,
        localised_name = { "setting-name.cargowagon_small_max_health" },
        localised_description = { "setting-description.cargowagon_small_max_health" },
        order = "b06"
    },
    {
        type = "int-setting",
        name = "cargowagon_small_weight",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 750,
        maximum_value = 10000,
        localised_name = { "setting-name.cargowagon_small_weight" },
        localised_description = { "setting-description.cargowagon_small_weight" },
        order = "b07"
    },
    {
        type = "int-setting",
        name = "cargowagon_small_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 250,
        maximum_value = 500,
        localised_name = { "setting-name.cargowagon_small_max_speed" },
        localised_description = { "setting-description.cargowagon_small_max_speed" },
        order = "b08"
    },
    -- Cargo wagon normal settings
    {
        type = "int-setting",
        name = "cargowagon_normal_inventory_size",
        setting_type = "startup",
        minimum_value = 1,
        default_value = 40,
        maximum_value = 100,
        localised_name = { "setting-name.cargowagon_normal_inventory_size" },
        localised_description = { "setting-description.cargowagon_normal_inventory_size" },
        order = "b09"
    },
    {
        type = "int-setting",
        name = "cargowagon_normal_max_health",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 600,
        maximum_value = 1000,
        localised_name = { "setting-name.cargowagon_normal_max_health" },
        localised_description = { "setting-description.cargowagon_normal_max_health" },
        order = "b10"
    },
    {
        type = "int-setting",
        name = "cargowagon_normal_weight",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 1000,
        maximum_value = 10000,
        localised_name = { "setting-name.cargowagon_normal_weight" },
        localised_description = { "setting-description.cargowagon_normal_weight" },
        order = "b11"
    },
    {
        type = "int-setting",
        name = "cargowagon_normal_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 500,
        maximum_value = 500,
        localised_name = { "setting-name.cargowagon_normal_max_speed" },
        localised_description = { "setting-description.cargowagon_normal_max_speed" },
        order = "b12"
    },
    --
    -- Fluid wagon tiny settings
    -- not yet implemented in the mod
    --
    -- Fluid wagon small defaults
    {
        type = "int-setting",
        name = "fluidwagon_small_capacity",
        setting_type = "startup",
        minimum_value = 1000,
        default_value = 26250,
        maximum_value = 100000,
        localised_name = { "setting-name.fluidwagon_small_capacity" },
        localised_description = { "setting-description.fluidwagon_small_capacity" },
        order = "c01"
    },
    {
        type = "int-setting",
        name = "fluidwagon_small_max_health",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 450,
        maximum_value = 1000,
        localised_name = { "setting-name.fluidwagon_small_max_health" },
        localised_description = { "setting-description.fluidwagon_small_max_health" },
        order = "c02"
    },
    {
        type = "int-setting",
        name = "fluidwagon_small_weight",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 750,
        maximum_value = 10000,
        localised_name = { "setting-name.fluidwagon_small_weight" },
        localised_description = { "setting-description.fluidwagon_small_weight" },
        order = "c03"
    },
    {
        type = "int-setting",
        name = "fluidwagon_small_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 250,
        maximum_value = 500,
        localised_name = { "setting-name.fluidwagon_small_max_speed" },
        localised_description = { "setting-description.fluidwagon_small_max_speed" },
        order = "c04"
    },

    -- Fluid wagon normal defaults
    {
        type = "int-setting",
        name = "fluidwagon_normal_capacity",
        setting_type = "startup",
        minimum_value = 1000,
        default_value = 50000,
        maximum_value = 100000,
        localised_name = { "setting-name.fluidwagon_normal_capacity" },
        localised_description = { "setting-description.fluidwagon_normal_capacity" },
        order = "c05"
    },
    {
        type = "int-setting",
        name = "fluidwagon_normal_max_health",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 600,
        maximum_value = 1000,
        localised_name = { "setting-name.fluidwagon_normal_max_health" },
        localised_description = { "setting-description.fluidwagon_normal_max_health" },
        order = "c06"
    },
    {
        type = "int-setting",
        name = "fluidwagon_normal_weight",
        setting_type = "startup",
        minimum_value = 50,
        default_value = 1000,
        maximum_value = 10000,
        localised_name = { "setting-name.fluidwagon_normal_weight" },
        localised_description = { "setting-description.fluidwagon_normal_weight" },
        order = "c07"
    },
    {
        type = "int-setting",
        name = "fluidwagon_normal_max_speed",
        setting_type = "startup",
        minimum_value = 10,
        default_value = 500,
        maximum_value = 500,
        localised_name = { "setting-name.fluidwagon_normal_max_speed" },
        localised_description = { "setting-description.fluidwagon_normal_max_speed" },
        order = "c08"
    },
    -- Recipe cost settings
    {
        type = "int-setting",
        name = "cheap-recipe-how-many-times-cheaper",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        localised_name = { "setting-name.cheap-recipe-how-many-times-cheaper" },
        localised_description = { "setting-description.cheap-recipe-how-many-times-cheaper" },
        order = "e"
    },
    {
        type = "int-setting",
        name = "expensive-recipe-how-many-times-more-expensive",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        localised_name = { "setting-name.expensive-recipe-how-many-times-more-expensive" },
        localised_description = { "setting-description.expensive-recipe-how-many-times-more-expensive" },
        order = "f"
    },
})

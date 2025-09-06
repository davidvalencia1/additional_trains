local trainWheel = {}

trainWheel.noWheels =
{
    rotated =
    {
        priority = "very-low",
        width = 1,
        height = 1,
        direction_count = 1,
        filenames =
        {
            "__additional_trains__/graphics/entity/empty.png",
        },
        line_length = 1,
        lines_per_file = 1,
    }
}

trainWheel.standardTrainWheels =
{
    -- from railwaymod
    -- rotated =
    -- {
    --     priority = "very-low",
    --     width = 1,
    --     height = 1,
    --     direction_count = 1,
    --     filenames =
    --     {
    --         "__base__/graphics/entity/train-wheel/train-wheel",
    --     },
    --     line_length = 1,
    --     lines_per_file = 1,
    -- }
    --original code from game
    rotated = util.sprite_load("__base__/graphics/entity/train-wheel/train-wheel",
        {
            priority = "very-low",
            direction_count = 256,
            scale = 0.5,
            shift = util.by_pixel(0, 8),
            usage = "train"
        }
    )
}
return trainWheel

local const = {}
local _const = {}

_const.VEHICLE_SIZE = {
    NORMAL = "normal",
    SMALL = "small",
    TINY = "tiny"
}
_const.VEHICLE_TYPE = {
    LOCOMOTIVE = "locomotive",
    CARGO_WAGON = "cargo-wagon",
    FLUID_WAGON = "fluid-wagon"
}
_const.VEHICLE_TYPE_SUBGROUPS = {
    [_const.VEHICLE_TYPE.LOCOMOTIVE] = {
        [_const.VEHICLE_SIZE.TINY] = {
            name = "locomotives-tiny",
            order = "a1"
        },
        [_const.VEHICLE_SIZE.SMALL] = {
            name = "locomotives-small",
            order = "a2"
        },
        [_const.VEHICLE_SIZE.NORMAL] = {
            name = "locomotives-normal",
            order = "a3"
        }
    },
    [_const.VEHICLE_TYPE.CARGO_WAGON] = {
        [_const.VEHICLE_SIZE.TINY] = {
            name = "cargo-wagon-tiny",
            order = "b1"
        },
        [_const.VEHICLE_SIZE.SMALL] = {
            name = "cargo-wagon-small",
            order = "b2"
        },
        [_const.VEHICLE_SIZE.NORMAL] = {
            name = "cargo-wagon-normal",
            order = "b3"
        }
    },
    [_const.VEHICLE_TYPE.FLUID_WAGON] = {
        [_const.VEHICLE_SIZE.TINY] = {
            name = "fluid-wagon-tiny",
            order = "c1"
        },
        [_const.VEHICLE_SIZE.SMALL] = {
            name = "fluid-wagon-small",
            order = "c2"
        },
        [_const.VEHICLE_SIZE.NORMAL] = {
            name = "fluid-wagon-normal",
            order = "c3"
        }
    }
}

setmetatable(const, {
    __index = _const,
    __newindex = function(_, key, _)
        error("Attempt to modify a constant: " .. key)
    end
})

return const

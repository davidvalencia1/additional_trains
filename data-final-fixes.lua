-- data-final-fixes.lua
local const = require("prototypes.const")
local recipe = require("prototypes.recipe")

-- Actualizamos STANDARD_RECIPE al inicio
log("Updating standard recipes...")
recipe.setStandardRecipes()

-- Mapeo de palabras clave a tipo de vehiculo
local TYPE_MAP = {
    LOCOMOTIVE = const.VEHICLE_TYPE.LOCOMOTIVE,
    CARGO      = const.VEHICLE_TYPE.CARGO_WAGON,
    FLUID      = const.VEHICLE_TYPE.FLUID_WAGON,
}

local sizeSuffixPattern = "_(" .. table.concat(const.VEHICLE_SIZE, "|") .. ")$"

-- Mapeo de sufijos a tamaio
local SIZE_MAP = {
    TINY   = const.VEHICLE_SIZE.TINY,
    SMALL  = const.VEHICLE_SIZE.SMALL,
    NORMAL = const.VEHICLE_SIZE.NORMAL,
}

for name, rec in pairs(data.raw["recipe"]) do
    if string.sub(name, 1, 3) == "at_" then
        local vtype, vsize
        -- Detecta tipo
        for _, val in pairs(TYPE_MAP) do
            log("Checking name " .. name .. " for type " .. val)
            if string.find(name, val, 1, true) then
                log("Found matching type: " .. val)
                vtype = val
                break
            end
        end

        -- Detecta tamano
        for _, val in pairs(SIZE_MAP) do
            if string.find(name, val, 1, true) then
                vsize = val
                break
            end
        end

        -- fallback si no encontro nada
        vsize = vsize or const.VEHICLE_SIZE.NORMAL

        if vtype then
            local entity = { name = name, type = vtype, size = vsize }
            local upgradedIngredients = recipe.createRecipe(entity).ingredients

            local newName = name
                :gsub("^at_", "")
                :gsub(sizeSuffixPattern, "")
                :gsub("_" .. vtype, "")

            rec.ingredients = upgradedIngredients
            if not data.raw["recipe"][newName] then
                rec.name = newName
                data.raw["recipe"][newName] = rec
                data.raw["recipe"][name] = nil -- borramos la receta vieja con sufijo
            end

        end
    end
end

-- data-final-fixes.lua
local utility = require("utility")
local const = require("const")
local recipe = require("recipe")

-- Actualizamos STANDARD_RECIPE al inicio
recipe.setStandardRecipes()

-- Mapeo de palabras clave a tipo de vehiculo
local TYPE_MAP = {
    locomotive = const.VEHICLE_TYPE.LOCOMOTIVE,
    cargo      = const.VEHICLE_TYPE.CARGO_WAGON,
    fluid      = const.VEHICLE_TYPE.FLUID_WAGON,
}

-- Mapeo de sufijos a tamaio
local SIZE_MAP = {
    tiny   = const.VEHICLE_SIZE.TINY,
    small  = const.VEHICLE_SIZE.SMALL,
    normal = const.VEHICLE_SIZE.NORMAL,
}

for name, rec in pairs(data.raw["recipe"]) do
    if string.sub(name, 1, 3) == "at_" then
        local vtype, vsize

        -- Detecta tipo
        for key, val in pairs(TYPE_MAP) do
            if string.find(name, key) then
                vtype = val
                break
            end
        end

        -- Detecta tamano
        for key, val in pairs(SIZE_MAP) do
            if string.find(name, key) then
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
                :gsub("^at_", "")                 -- quita el prefijo
                :gsub("_(tiny|small|normal)$", "") -- quita el sufijo
                
            rec.ingredients = upgradedIngredients

            if not data.raw["recipe"][newName] then
                rec.name = newName
                data.raw["recipe"][newName] = rec
                data.raw["recipe"][name] = nil -- borramos la receta vieja con sufijo
            end

        end
    end
end

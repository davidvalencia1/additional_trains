local utility = require("utility")
local const = require("const")
local recipe = {}

local STANDARD_RECIPE = {}

-- Funcion para actualizar STANDARD_RECIPE desde afuera
function recipe.setStandardRecipes()
    STANDARD_RECIPE = {
        [const.VEHICLE_TYPE.LOCOMOTIVE]  = data.raw["recipe"]["locomotive"].ingredients,
        [const.VEHICLE_TYPE.CARGO_WAGON] = data.raw["recipe"]["cargo-wagon"].ingredients,
        [const.VEHICLE_TYPE.FLUID_WAGON] = data.raw["recipe"]["fluid-wagon"].ingredients
    }
end

recipe.setStandardRecipes()

local RECIPE_COST = {
    [const.VEHICLE_SIZE.TINY] = settings.startup["cheap-recipe-how-many-times-cheaper"].value,
    [const.VEHICLE_SIZE.SMALL] = 1, -- same as standard recipe for locomotive / cargo wagon etc
    [const.VEHICLE_SIZE.NORMAL] = settings.startup["expensive-recipe-how-many-times-more-expensive"].value
}

local function getRecipeCostCalculator(size)

    local divideRecipeCost = function(amount, divider)
        local result = math.floor(amount / divider)
        if result == 0 then
            return 1
        end
        return result
    end

    local mutiplyRecipeCost = function(amount, multiplier)
        return amount * multiplier
    end

    -- local calculate = {
    --     [const.VEHICLE_SIZE.TINY] = divideRecipeCost,
    --     [const.VEHICLE_SIZE.SMALL] = mutiplyRecipeCost,
    --     [const.VEHICLE_SIZE.NORMAL] = mutiplyRecipeCost
    -- }

    if(size == const.VEHICLE_SIZE.NORMAL or size == const.VEHICLE_SIZE.SMALL) then
        return mutiplyRecipeCost
    else
        return divideRecipeCost

    end


    --return calculate
end

local function updateIngriedientsCost(ingredients, entity)
    local clone = utility.copy(ingredients)
    local cost = RECIPE_COST[entity.size]
    local calc = getRecipeCostCalculator(entity.size)
    for key, ingredient in pairs(clone) do
        local updatedCost = calc(ingredient.amount, cost)
        clone[key].amount = updatedCost
    end
    return clone
end

local function standardTrainsUseExpensiveRecipe()
    data.raw["recipe"]["locomotive"].ingredients = updateIngriedientsCost(data.raw["recipe"]["locomotive"].ingredients, {size = const.VEHICLE_SIZE.NORMAL})
    data.raw["recipe"]["cargo-wagon"].ingredients = updateIngriedientsCost(data.raw["recipe"]["cargo-wagon"].ingredients, {size = const.VEHICLE_SIZE.NORMAL})
    data.raw["recipe"]["fluid-wagon"].ingredients = updateIngriedientsCost(data.raw["recipe"]["fluid-wagon"].ingredients, {size = const.VEHICLE_SIZE.NORMAL})
end
standardTrainsUseExpensiveRecipe()

local function createBasicRecipe(entity, ingredients, subgroupName)
    return {
        type = "recipe",
        name = "at_" .. entity.name .. entity.size,
        enabled = true,
        energy_required = 5.00,
        ingredients = ingredients,
        results = {{
            type = "item",
            name = entity.name,
            amount = 1
        }},
        main_product = entity.name,
        order = "a",
        subgroup = subgroupName
    }
end

function recipe.createRecipe(entity)
    local ingredients = STANDARD_RECIPE[entity.type]
    local upgradedIngredients = updateIngriedientsCost(ingredients, entity)

    local subgroupName = utility.getSubgroupName(entity)
    return createBasicRecipe(entity, upgradedIngredients, subgroupName)
end

return recipe
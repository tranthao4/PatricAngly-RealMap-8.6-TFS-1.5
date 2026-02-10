local function revertItem(position, itemId, transformId)
    local item = Tile(position):getItemById(itemId)
    if item then
        item:transform(transformId)
    end
end

local woteKeeper = MoveEvent()
woteKeeper:type("stepin")

function woteKeeper.onStepIn(creature, item, position, fromPosition)
    local monster = creature:isMonster()
    if not monster then
        return true
    end

    if creature:getName():lower() ~= 'the keeper' then
        return true
    end

    damage = math.random(6000, 8000)
    creature:addHealth(-damage)

    item:transform(12335)
    addEvent(revertItem, math.random(10, 30) * 1000, position, 12335, 12334)
    return true
end

woteKeeper:id(12334)
woteKeeper:register()


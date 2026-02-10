local enterPosition = Position(32519, 32911, 7)
local exitPosition = Position(32519, 32912, 7)

local assassinErayoHouse = MoveEvent()
assassinErayoHouse:type("stepin")

function assassinErayoHouse.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if not (position == enterPosition) then
        return true
    end

    if not player:getItemById(2202, true) and not player:getCondition(CONDITION_INVISIBLE) then
        player:teleportTo(exitPosition)
    end

    return true
end

assassinErayoHouse:id(3139)
assassinErayoHouse:register()


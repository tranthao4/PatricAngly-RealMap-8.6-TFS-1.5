-- Entrance
local deathlingsEntrance = MoveEvent()
deathlingsEntrance:type("stepin")

function deathlingsEntrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item.actionid == 64017 then
        local destination = Position(32881, 32474, 9)
        player:teleportTo(destination)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        destination:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

deathlingsEntrance:aid(64017)
deathlingsEntrance:register()

-- Exit
local deathlingsExit = MoveEvent()
deathlingsExit:type("stepin")

function deathlingsExit.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return
    end

    if item.actionid == 64018 then
        local destination = Position(32870, 32510, 7)
        player:teleportTo(destination)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        destination:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

deathlingsExit:aid(64018)
deathlingsExit:register()


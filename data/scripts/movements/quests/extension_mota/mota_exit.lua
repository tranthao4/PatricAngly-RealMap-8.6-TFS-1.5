local destination = {
    [64016] = {newPos = Position(33246, 32108, 8)}
}

local motaExit = MoveEvent()
motaExit:type("stepin")

function motaExit.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return
    end

    local teleport = destination[item.actionid]
    if not teleport then
        return
    end

    player:teleportTo(teleport.newPos)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

motaExit:aid(64016)
motaExit:register()


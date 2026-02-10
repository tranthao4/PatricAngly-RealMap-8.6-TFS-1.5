local tatEnterDiprath = MoveEvent()
tatEnterDiprath:type("stepin")

function tatEnterDiprath.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if Game.getStorageValue(GlobalStorage.TheAncientTombs.DiprathSwitchesGlobalStorage) < 7 then
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    local destination = Position(33083, 32568, 14)
    player:teleportTo(destination)
    destination:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

tatEnterDiprath:aid(50131)
tatEnterDiprath:register()


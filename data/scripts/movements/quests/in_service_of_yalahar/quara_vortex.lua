local isoyQuaraVortex = MoveEvent()
isoyQuaraVortex:type("stepin")

function isoyQuaraVortex.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getSlotItem(CONST_SLOT_HEAD) and player:getSlotItem(CONST_SLOT_HEAD).itemid == 5460 then
        player:teleportTo(Position(32802, 31165, 9))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You need to wear a helmet of the deep to enter this vortex.')
    end
    return true
end

isoyQuaraVortex:aid(50162)
isoyQuaraVortex:register()


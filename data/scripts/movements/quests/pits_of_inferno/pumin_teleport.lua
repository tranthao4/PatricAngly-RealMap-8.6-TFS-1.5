local puminTeleport = MoveEvent()
puminTeleport:type("stepin")

function puminTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.PitsOfInferno.ThronePumin) < 50 then
        player:teleportTo(Position(32786, 32308, 15))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'To enter Pumin\'s domain you must gain permission from the bureaucrats.')
    end
    return true
end

puminTeleport:aid(2066)
puminTeleport:register()


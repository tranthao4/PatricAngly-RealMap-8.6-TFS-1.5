local qobFifthSealPath = MoveEvent()
qobFifthSealPath:type("stepin")

function qobFifthSealPath.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item.actionid == 50014 then
        position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        player:teleportTo({x = 32185, y = 31939, z = 14}, false)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

qobFifthSealPath:aid(50013, 50014)
qobFifthSealPath:register()


local poiTrap = MoveEvent()
poiTrap:type("stepin")

function poiTrap.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return
    end

    position.z = position.z + 1
    player:teleportTo(position)
    position:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
    return true
end

poiTrap:aid(2067)
poiTrap:register()


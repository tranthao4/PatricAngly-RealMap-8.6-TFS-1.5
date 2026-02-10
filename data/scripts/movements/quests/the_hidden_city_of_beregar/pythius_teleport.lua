local beregarPythiusTeleport = MoveEvent()
beregarPythiusTeleport:type("stepin")

function beregarPythiusTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local destination = Position(32601, 31397, 14)
    player:teleportTo(destination)
    position:sendMagicEffect(CONST_ME_TELEPORT)
    destination:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

beregarPythiusTeleport:aid(50128)
beregarPythiusTeleport:register()


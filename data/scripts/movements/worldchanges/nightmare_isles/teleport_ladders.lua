local config = {
    [64103] = Position(33475, 32641, 10),
    [64104] = Position(33473, 32647, 9),
    [64105] = Position(33463, 32585, 8),
    [64106] = Position(33457, 32580, 8),
    [64107] = Position(33422, 32582, 8),
    [64108] = Position(33430, 32600, 10),
    [64109] = Position(33420, 32604, 10),
    [64120] = Position(33446, 32616, 11),
    [64121] = Position(33460, 32632, 10),
    [64122] = Position(33429, 32626, 10),
    [64123] = Position(33425, 32633, 8),
    [64124] = Position(33435, 32631, 8),
    [64125] = Position(33478, 32621, 10),
    [64126] = Position(33484, 32629, 8),
    [64127] = Position(33452, 32617, 11),
    [64128] = Position(33419, 32589, 10)
}

local nightmareIslesTeleportLadders = MoveEvent()
nightmareIslesTeleportLadders:type("stepin")

function nightmareIslesTeleportLadders.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local targetPosition = config[item.actionid]
    if not targetPosition then
        return true
    end

    player:teleportTo(targetPosition)
    position:sendMagicEffect(CONST_ME_TELEPORT)
    targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

nightmareIslesTeleportLadders:aid(64103, 64104, 64105, 64106, 64107, 64108, 64109, 64120, 64121, 64122, 64123, 64124, 64125, 64126, 64127, 64128)
nightmareIslesTeleportLadders:register()


local exitPosition = Position(32369, 32241, 7) -- Thais temple

local trainingExit = MoveEvent()
trainingExit:type("stepin")

function trainingExit.onStepIn(player, item, position, fromPosition)
    if not player or not player:isPlayer() then
        return true
    end

    player:teleportTo(exitPosition)
    exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

trainingExit:aid(38554)
trainingExit:register()


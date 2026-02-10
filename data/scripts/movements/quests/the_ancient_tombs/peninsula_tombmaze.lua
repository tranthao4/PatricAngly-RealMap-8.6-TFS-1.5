local tatPeninsulaTombmaze = MoveEvent()
tatPeninsulaTombmaze:type("stepin")

function tatPeninsulaTombmaze.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    player:teleportTo(fromPosition)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

tatPeninsulaTombmaze:aid(50134)
tatPeninsulaTombmaze:register()


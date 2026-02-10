local config = {
    [16772] = Position(32754, 32365, 15),
    [16773] = Position(32725, 32381, 15),
    [16774] = Position(32827, 32241, 12)
}

local bazirTiles = MoveEvent()
bazirTiles:type("stepin")

function bazirTiles.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local targetPosition = config[item.actionid]
    if not targetPosition then
        return true
    end

    player:teleportTo(targetPosition)
    return true
end

bazirTiles:aid(16772, 16773, 16774)
bazirTiles:register()


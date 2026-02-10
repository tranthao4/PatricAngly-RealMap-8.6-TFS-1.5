local decayTiles = MoveEvent()
decayTiles:type("stepin")

function decayTiles.onStepIn(creature, item, position, fromPosition)
    item:transform(item.itemid + 1)
    item:decay()
    return true
end

decayTiles:id(293, 461, 3310)
decayTiles:register()


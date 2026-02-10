local bridgePosition = Position(32851, 32309, 11)
local relocatePosition = Position(32852, 32310, 11)
local dirtIds = {4808, 4810}

-- StepIn event
local poiDrawbridgeStepIn = MoveEvent()
poiDrawbridgeStepIn:type("stepin")

function poiDrawbridgeStepIn.onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end

    local tile = Tile(bridgePosition)
    local lavaItem = tile:getItemById(598)
    if lavaItem then
        lavaItem:transform(1284)

        local dirtItem
        for i = 1, #dirtIds do
            dirtItem = tile:getItemById(dirtIds[i])
            if dirtItem then
                dirtItem:remove()
            end
        end
    end
    return true
end

poiDrawbridgeStepIn:aid(2065)
poiDrawbridgeStepIn:register()

-- StepOut event
local poiDrawbridgeStepOut = MoveEvent()
poiDrawbridgeStepOut:type("stepout")

function poiDrawbridgeStepOut.onStepOut(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end

    local tile = Tile(bridgePosition)
    local bridgeItem = tile:getItemById(1284)
    if bridgeItem then
        tile:relocateTo(relocatePosition)
        bridgeItem:transform(598)

        for i = 1, #dirtIds do
            Game.createItem(dirtIds[i], 1, bridgePosition)
        end
    end
    return true
end

poiDrawbridgeStepOut:aid(2065)
poiDrawbridgeStepOut:register()


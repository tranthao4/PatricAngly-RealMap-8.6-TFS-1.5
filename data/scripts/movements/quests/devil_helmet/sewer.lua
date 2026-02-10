local sewerPosition = Position(32482, 32170, 14)

-- StepIn event
local devilHelmetSewerStepIn = MoveEvent()
devilHelmetSewerStepIn:type("stepin")

function devilHelmetSewerStepIn.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player == nil then
        return true
    end

    local tile = Tile(sewerPosition)
    if tile then
        local tileItem = tile:getItemById(430)
        if not tileItem then
            Game.createItem(430, 1, sewerPosition)
        end
    end
    return true
end

devilHelmetSewerStepIn:aid(50154)
devilHelmetSewerStepIn:register()

-- StepOut event
local devilHelmetSewerStepOut = MoveEvent()
devilHelmetSewerStepOut:type("stepout")

function devilHelmetSewerStepOut.onStepOut(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if player == nil then
        return true
    end

    local tile = Tile(sewerPosition)
    if tile then
        local tileItem = tile:getItemById(430)
        if tileItem then
            tileItem:remove(1)
        end
    end

    return true
end

devilHelmetSewerStepOut:aid(50154)
devilHelmetSewerStepOut:register()


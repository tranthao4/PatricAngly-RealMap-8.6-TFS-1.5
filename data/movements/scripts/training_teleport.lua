local roomPositions = {
    Position(32349, 33086, 7),
    Position(32353, 33086, 7),
}

local function isRoomOccupied(pos)
    local tile = Tile(pos)
    if tile then
        local creatures = tile:getCreatures()
        if creatures then
            for i = 1, #creatures do
                if creatures[i]:isPlayer() then
                    return true
                end
            end
        end
    end
    return false
end

function onStepIn(player, item, position, fromPosition)
    if not player or not player:isPlayer() then
        return true
    end

    for _, roomPos in ipairs(roomPositions) do
        if not isRoomOccupied(roomPos) then
            player:teleportTo(roomPos)
            roomPos:sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end

    player:sendTextMessage(MESSAGE_STATUS_SMALL, "All training rooms are occupied. Please try again later.")
    player:teleportTo(fromPosition, true)
    fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

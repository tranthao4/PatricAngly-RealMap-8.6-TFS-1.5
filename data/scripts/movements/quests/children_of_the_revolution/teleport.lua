local config = {
    [3167] = {storageKey = Storage.ChildrenoftheRevolution.Questline, toPosition = {Position(33257, 31116, 8), Position(33356, 31126, 7)}},
    [3168] = {storageKey = Storage.ChildrenoftheRevolution.Questline, toPosition = {Position(33356, 31125, 7), Position(33356, 31125, 7)}}
}

local cotrTeleport = MoveEvent()
cotrTeleport:type("stepin")

function cotrTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local targetTile = config[item.uid]
    if not targetTile then
        return true
    end

    local hasStorageValue = player:getStorageValue(targetTile.storageKey) >= 19
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:teleportTo(targetTile.toPosition[hasStorageValue and 1 or 2])
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

cotrTeleport:uid(3167, 3168)
cotrTeleport:register()


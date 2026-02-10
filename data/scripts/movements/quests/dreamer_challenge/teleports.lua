local teleports = {
    [2250] = Position(32915, 32263, 14),
    [2251] = Position(32946, 32270, 13),
    [2252] = Position(32976, 32270, 14),
    [2253] = Position(32933, 32282, 13),
    [2254] = Position(32753, 32344, 14),
    [2255] = Position(32753, 32344, 14)
}

local dcTeleports = MoveEvent()
dcTeleports:type("stepin")

function dcTeleports.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end

    local destination = teleports[item.uid]
    if destination then
        player:teleportTo(destination)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

dcTeleports:uid(2250, 2251, 2252, 2253, 2254, 2255)
dcTeleports:register()


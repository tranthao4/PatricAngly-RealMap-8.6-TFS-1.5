local teleports = {
    [3178] = {value = 6, position = Position(33137, 31248, 6)},
    [3179] = {value = 6, position = Position(33211, 31068, 9)},
    [3180] = {value = 6, position = Position(33211, 31068, 9)},
}

local woteTeleports = MoveEvent()
woteTeleports:type("stepin")

function woteTeleports.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleport = teleports[item.uid]
    if not teleport then
        return true
    end

    if player:getStorageValue(Storage.WrathoftheEmperor.TeleportAccess) >= teleport.value then
        player:teleportTo(teleport.position)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        player:teleportTo(fromPosition)
    end
    return true
end

woteTeleports:uid(3178, 3179, 3180)
woteTeleports:register()


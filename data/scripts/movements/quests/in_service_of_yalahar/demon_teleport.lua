local teleports = {
    [3103] = {destination = Position(32861, 31061, 9), soilPosition = Position(32859, 31056, 9)},
    [3104] = {destination = Position(32856, 31055, 9)},
    [3105] = {destination = Position(32888, 31045, 9), soilPosition = Position(32894, 31044, 9)},
    [3106] = {destination = Position(32894, 31046, 9)},
}

local isoyDemonTeleport = MoveEvent()
isoyDemonTeleport:type("stepin")

function isoyDemonTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleport = teleports[item.uid]
    if not teleport then
        return true
    end

    player:teleportTo(teleport.destination)
    teleport.destination:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

isoyDemonTeleport:uid(3103, 3104, 3105, 3106)
isoyDemonTeleport:register()


local sacrificePosition = Position(32243, 31892, 14)
local destination = Position(32261, 31849, 15)

local qobFourthSealFlame = MoveEvent()
qobFourthSealFlame:type("stepin")

function qobFourthSealFlame.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.QueenOfBansheesQuest.FourthSeal) >= 1 then
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    local bloodItem = Tile(sacrificePosition):getItemById(2016, 2)
    if not bloodItem then
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    bloodItem:remove()
    player:setStorageValue(Storage.QueenOfBansheesQuest.FourthSeal, 1)
    player:teleportTo(destination)
    destination:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

qobFourthSealFlame:aid(50004)
qobFourthSealFlame:register()


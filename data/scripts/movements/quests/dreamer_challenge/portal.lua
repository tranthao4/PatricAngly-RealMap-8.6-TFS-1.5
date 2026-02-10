local sacrificee = Position(32844, 32228, 14)   --Master
local sacrificee2 = Position(32835, 32225, 14)  --Master price
local ssacrificee3 = Position(32790, 32227, 14) --bone
local ssacrificee4 = Position(32784, 32226, 14) --bone price

local dcPortal = MoveEvent()
dcPortal:type("stepin")

function dcPortal.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if item.actionid == 50149 then
        if player:getStorageValue(Storage.OutfitQuest.NightmareOutfit) >= 2 then
            player:teleportTo(sacrificee2)
            sacrificee2:sendMagicEffect(CONST_ME_POFF)
        else
            player:teleportTo(sacrificee)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    elseif item.actionid == 50150 then
        if player:getStorageValue(Storage.OutfitQuest.BrotherhoodOutfit) >= 2 then
            player:teleportTo(ssacrificee4)
            ssacrificee4:sendMagicEffect(CONST_ME_POFF)
        else
            player:teleportTo(ssacrificee3)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end
    return true
end

dcPortal:aid(50149, 50150)
dcPortal:register()


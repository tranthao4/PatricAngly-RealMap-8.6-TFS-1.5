local teleports = {
    [2150] = {text = 'Entering Ushuriel\'s ward.', newPos = Position(33158, 31728, 11), storage = 0, alwaysSetStorage = true},
    [2151] = {text = 'Entering the Crystal Caves.', bossStorage = 200, newPos = Position(33069, 31782, 13), storage = 1},
    [2152] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2153] = {text = 'Entering the Crystal Caves.', newPos = Position(33069, 31782, 13), storage = 1},
    [2154] = {text = 'Entering the Sunken Caves.', newPos = Position(33169, 31755, 13)},
    [2155] = {text = 'Entering the Mirror Maze of Madness.', newPos = Position(33065, 31772, 10)},
    [2156] = {text = 'Entering Zugurosh\'s ward.', newPos = Position(33124, 31692, 11)},
    [2157] = {text = 'Entering the Blood Halls.', bossStorage = 201, newPos = Position(33372, 31613, 14), storage = 2},
    [2158] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2159] = {text = 'Entering the Blood Halls.', newPos = Position(33372, 31613, 14), storage = 2},
    [2160] = {text = 'Entering the Foundry.', newPos = Position(33356, 31589, 11)},
    [2161] = {text = 'Entering Madareth\'s ward.', newPos = Position(33197, 31767, 11)},
    [2162] = {text = 'Entering the Vats.', bossStorage = 202, newPos = Position(33153, 31782, 12), storage = 3},
    [2163] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2164] = {text = 'Entering the Vats.', newPos = Position(33153, 31782, 12), storage = 3},
    [2165] = {text = 'Entering the Battlefield.', newPos = Position(33250, 31632, 13)},
    [2166] = {text = 'Entering the Vats.', newPos = Position(33233, 31758, 12)},
    [2167] = {text = 'Entering the Demon Forge.', newPos = Position(33232, 31733, 11)},
    [2168] = {text = 'Entering the Arcanum.', bossStorage = 203, newPos = Position(33038, 31753, 15), storage = 4},
    [2169] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2170] = {text = 'Entering the Arcanum.', newPos = Position(33038, 31753, 15), storage = 4},
    [2171] = {text = 'Entering the Soul Wells.', newPos = Position(33093, 31575, 11)},
    [2172] = {text = 'Entering the Arcanum.', newPos = Position(33186, 31759, 15)},
    [2173] = {text = 'Entering the Annihilon\'s ward.', newPos = Position(33197, 31703, 11)},
    [2174] = {text = 'Entering the Hive.', bossStorage = 204, newPos = Position(33199, 31686, 12), storage = 5},
    [2175] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2176] = {text = 'Entering the Hive.', newPos = Position(33199, 31686, 12), storage = 5},
    [2177] = {text = 'Entering the Hellgorak\'s ward.', newPos = Position(33104, 31734, 11)},
    [2178] = {text = 'Entering the Shadow Nexus. Abandon all Hope.', bossStorage = 205, newPos = Position(33110, 31682, 12), storage = 6},
    [2179] = {text = 'Escaping back to the Retreat.', newPos = Position(33165, 31709, 14)},
    [2180] = {text = 'Entering the Blood Halls.', newPos = Position(33357, 31589, 12)}
}

local inquisitionTeleportMain = MoveEvent()
inquisitionTeleportMain:type("stepin")

function inquisitionTeleportMain.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local teleport = teleports[item.uid]
    if not teleport then
        return true
    end

    if teleport.alwaysSetStorage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
        player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
    end

    if teleport.bossStorage then
        if Game.getStorageValue(teleport.bossStorage) >= 2 then
            if player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
                player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
                player:setStorageValue(teleport.bossStorage, 0)
            end
        else
            player:teleportTo(Position(33165, 31709, 14))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:say('Escaping back to the Retreat.', TALKTYPE_MONSTER_SAY)
            return true
        end
    elseif teleport.storage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:say('You don\'t have enough energy to enter this portal', TALKTYPE_MONSTER_SAY)
        return true
    end

    player:teleportTo(teleport.newPos)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:say(teleport.text, TALKTYPE_MONSTER_SAY)
    return true
end

for uid, _ in pairs(teleports) do
    inquisitionTeleportMain:uid(uid)
end
inquisitionTeleportMain:register()


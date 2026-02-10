local SPECIAL_QUESTS = {2215, 2216, 10544, 12374, 12513, 26300, 27300, 28300}

local walkback = MoveEvent()
walkback:type("stepin")

function walkback.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if (Container(item.uid) and not isInArray(SPECIAL_QUESTS, item.actionid) and item.uid > 65535) then
        return true
    end

    if position == fromPosition then
        if creature:isPlayer() then
            local temple = creature:getTown():getTemplePosition()
            creature:teleportTo(temple, false)
        else
            creature:remove()
        end
    else
        creature:teleportTo(fromPosition, false)
    end

    return true
end

walkback:id(1738, 1740, 1741, 1746, 1747, 1748, 1749, 1714, 1715, 1716, 1717, 23798, 23799, 23800, 23801, 23802, 23803, 23804, 23805)
walkback:register()


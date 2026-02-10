local pastries = {
    [2693] = 2689,
    [6277] = 6278,
    [9113] = 9111,
    [8846] = 8847
}

local dough = MoveEvent()
dough:type("additem")
dough:tileItem(true)

function dough.onAddItem(moveitem, tileitem, position)
    local pastryId = pastries[moveitem.itemid]
    if not pastryId then
        return true
    end

    moveitem:transform(pastryId)
    position:sendMagicEffect(CONST_ME_HITBYFIRE)
    return true
end

dough:id(1786, 1788, 1790, 1792)
dough:register()


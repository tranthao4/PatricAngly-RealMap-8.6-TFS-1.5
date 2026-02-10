-- StepIn event
local levelBridgeStepIn = MoveEvent()
levelBridgeStepIn:type("stepin")

function levelBridgeStepIn.onStepIn(cid, item, pos, topos)
    if isPlayer(cid) == TRUE and item.itemid == 446 then
        if getPlayerLevel(cid) >= 2 then
            doTransformItem(item.uid, item.itemid + 1)
        else
            position = getPlayerPosition(cid)
            newposition = {x = position.x, y = position.y + 1, z = position.z + 1}
            doPlayerSendTextMessage(cid, 22, "Only players with level 2 and above may leave the town!")
            doTeleportThing(cid, newposition)
            doSendMagicEffect(newposition, 13)
        end
    end
end

levelBridgeStepIn:aid(50998)
levelBridgeStepIn:register()

-- StepOut event
local levelBridgeStepOut = MoveEvent()
levelBridgeStepOut:type("stepout")

function levelBridgeStepOut.onStepOut(cid, item, pos, topos)
    if isPlayer(cid) == TRUE and item.itemid == 447 then
        doTransformItem(item.uid, item.itemid - 1)
    end
end

levelBridgeStepOut:aid(50998)
levelBridgeStepOut:register()


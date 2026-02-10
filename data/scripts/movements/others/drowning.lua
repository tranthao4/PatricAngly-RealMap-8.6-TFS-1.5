local condition = createConditionObject(CONDITION_DROWN)
setConditionParam(condition, CONDITION_PARAM_PERIODICDAMAGE, -20)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
setConditionParam(condition, CONDITION_PARAM_TICKINTERVAL, 2000)

local underWater = {5405, 5406, 5407, 5408, 5409, 5410, 5743, 5744, 5764, 9671, 9672, 9673, 10019}

-- StepIn event
local drowningStepIn = MoveEvent()
drowningStepIn:type("stepin")

function drowningStepIn.onStepIn(player, item, pos, fromPosition)
    local cid = player:getId()
    if player:isPlayer() then
        if player:getCondition(CONDITION_DROWN, CONDITIONID_COMBAT) == nil then
            doAddCondition(cid, condition)
        end
        if player:getStorageValue(17100) > os.time() then
            if player:getStorageValue(17101) < 1 then
                doChangeSpeed(cid, 600)
                player:setStorageValue(17101, 1)
            end
        end
    end

    if (math.random(1, 10) == 1) then
        Position(pos):sendMagicEffect(CONST_ME_BUBBLES)
    end
    return true
end

drowningStepIn:id(5405, 5406, 5407, 5408, 5409, 5410, 5743, 5744, 5764, 9671, 9672, 9673, 10019)
drowningStepIn:register()

-- StepOut event
local drowningStepOut = MoveEvent()
drowningStepOut:type("stepout")

function drowningStepOut.onStepOut(player, item, pos)
    local cid = player:getId()
    if player:isPlayer() then
        local ppos = player:getPosition()
        if (isInArray(underWater, getThingfromPos({x = ppos.x, y = ppos.y, z = ppos.z, stackpos = 0}).itemid)) then
            return true
        else
            doRemoveCondition(player, CONDITION_DROWN)
            if player:getStorageValue(17101) == 1 then
                doChangeSpeed(cid, 600 * (-1))
                player:setStorageValue(17101, 0)
            end
        end
    end
    return true
end

drowningStepOut:id(5405, 5406, 5407, 5408, 5409, 5410, 5743, 5744, 5764, 9671, 9672, 9673, 10019)
drowningStepOut:register()


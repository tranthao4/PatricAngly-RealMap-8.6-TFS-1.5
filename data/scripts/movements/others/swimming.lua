local condition = Condition(CONDITION_OUTFIT)
condition:setOutfit({lookType = 267})
condition:setTicks(-1)

-- StepIn event
local swimmingStepIn = MoveEvent()
swimmingStepIn:type("stepin")

function swimmingStepIn.onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return false
    end

    creature:addCondition(condition)
    return true
end

swimmingStepIn:id(4620, 4621, 4622, 4623, 4624, 4625)
swimmingStepIn:register()

-- StepOut event
local swimmingStepOut = MoveEvent()
swimmingStepOut:type("stepout")

function swimmingStepOut.onStepOut(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return false
    end

    creature:removeCondition(CONDITION_OUTFIT)
    return true
end

swimmingStepOut:id(4620, 4621, 4622, 4623, 4624, 4625)
swimmingStepOut:register()


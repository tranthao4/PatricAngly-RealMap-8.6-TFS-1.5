local inquisitionRewardText = MoveEvent()
inquisitionRewardText:type("stepin")

function inquisitionRewardText.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have proven yourself worthy. Choose your reward wisely.')
    return true
end

inquisitionRewardText:aid(50164)
inquisitionRewardText:register()


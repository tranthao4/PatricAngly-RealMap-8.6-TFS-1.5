local isoyMachineWargolems = MoveEvent()
isoyMachineWargolems:type("stepin")

function isoyMachineWargolems.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.InServiceofYalahar.Questline) == 52 then
        player:teleportTo(Position(32783, 31174, 10))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:say('The apparatus in the centre looks odd! You should inspect it.', TALKTYPE_MONSTER_SAY)
    else
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You don\'t have access to this area.')
    end
    return true
end

isoyMachineWargolems:aid(50163)
isoyMachineWargolems:register()


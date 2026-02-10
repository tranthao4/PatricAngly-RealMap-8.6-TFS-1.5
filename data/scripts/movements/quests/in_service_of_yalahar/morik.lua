local isoyMorik = MoveEvent()
isoyMorik:type("stepin")

function isoyMorik.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getStorageValue(Storage.InServiceofYalahar.Questline) == 45 then
        player:setStorageValue(Storage.InServiceofYalahar.Questline, 46)
        player:setStorageValue(Storage.InServiceofYalahar.Mission08, 3) -- Questlog, In Service of Yalahar Quest "Mission 08: Dangerous Machinations"
    end
    return true
end

isoyMorik:aid(50161)
isoyMorik:register()


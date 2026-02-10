local postmanTravel = MoveEvent()
postmanTravel:type("stepin")

function postmanTravel.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    player:setStorageValue(Storage.Postman.TravelCarlin, 1)
    player:setStorageValue(Storage.Postman.TravelThais, 1)
    return true
end

postmanTravel:aid(50165)
postmanTravel:register()


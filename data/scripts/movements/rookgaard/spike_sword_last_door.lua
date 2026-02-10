local spikeSwordLastDoor = MoveEvent()
spikeSwordLastDoor:type("stepin")

function spikeSwordLastDoor.onStepIn(cid, item, pos, topos)
    if isPlayer(cid) == TRUE then
        if getPlayerStorageValue(cid, 7041) <= 0 then
            setPlayerStorageValue(cid, 7041, 1)
        end
    end
end

spikeSwordLastDoor:aid(7037)
spikeSwordLastDoor:register()


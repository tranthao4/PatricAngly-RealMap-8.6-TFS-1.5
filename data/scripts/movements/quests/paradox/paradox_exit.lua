local paradoxExit = MoveEvent()
paradoxExit:type("stepin")

function paradoxExit.onStepIn(cid, item, pos)
    local exit1 = {x=32566, y=31963, z=1, stackpos=255}

    if item.actionid == 13004 then
        doTeleportThing(cid, exit1)
    end
    return true
end

paradoxExit:aid(13004)
paradoxExit:register()


local gotoCreature = TalkAction("/goto")

function gotoCreature.onSay(player, words, param)
    local target = Creature(param)
    if target then
        player:teleportTo(target:getPosition())
    else
        player:sendCancelMessage("Creature not found.")
    end
    return false
end

gotoCreature:separator(" ")
gotoCreature:access(true)
gotoCreature:register()


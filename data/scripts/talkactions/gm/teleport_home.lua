local teleportHome = TalkAction("/t")

function teleportHome.onSay(player, words, param)
    player:teleportTo(player:getTown():getTemplePosition())
    return false
end

teleportHome:access(true)
teleportHome:register()


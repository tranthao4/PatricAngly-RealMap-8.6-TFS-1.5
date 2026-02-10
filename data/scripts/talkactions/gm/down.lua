local down = TalkAction("/down")

function down.onSay(player, words, param)
    local position = player:getPosition()
    position.z = position.z + 1
    player:teleportTo(position)
    return false
end

down:access(true)
down:register()


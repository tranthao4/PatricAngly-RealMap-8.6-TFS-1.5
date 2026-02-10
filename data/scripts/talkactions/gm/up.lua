local up = TalkAction("/up")

function up.onSay(player, words, param)
    local position = player:getPosition()
    position.z = position.z - 1
    player:teleportTo(position)
    return false
end

up:access(true)
up:register()


local broadcast = TalkAction("/B")

function broadcast.onSay(player, words, param)
    if not player:hasFlag(PlayerFlag_CanBroadcast) then return true end

    print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
    for _, targetPlayer in ipairs(Game.getPlayers()) do
        targetPlayer:sendTextMessage(MESSAGE_STATUS_WARNING, param)
    end
    return false
end

broadcast:separator(" ")
broadcast:access(true)
broadcast:register()


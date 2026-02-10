local openserver = TalkAction("/openserver")

function openserver.onSay(player, words, param)
    Game.setGameState(GAME_STATE_NORMAL)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now open.")
    return false
end

openserver:accountType(ACCOUNT_TYPE_GOD)
openserver:access(true)
openserver:register()


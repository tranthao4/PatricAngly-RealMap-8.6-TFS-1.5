local uptime = TalkAction("!uptime")

function uptime.onSay(player, words, param)
    local uptimeSeconds = getWorldUpTime()

    local hours = math.floor(uptimeSeconds / 3600)
    local minutes = math.floor((uptimeSeconds - (3600 * hours)) / 60)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Uptime: " .. hours ..
                               " hours and " .. minutes .. " minutes.")
    return false
end

uptime:register()


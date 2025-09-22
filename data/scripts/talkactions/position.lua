local talk = TalkAction("/pos", "!pos")

function talk.onSay(player, words, param)
    -- access check
    if not player:getGroup():getAccess() then
        player:sendCancelMessage("You do not have permission to use this command.")
        return false
    end

    -- no args -> show current position
    if param == "" then
        local pos = player:getPosition()
        player:sendTextMessage(
            MESSAGE_STATUS_CONSOLE_BLUE,
            string.format("Your current position is: %d, %d, %d.", pos.x, pos.y, pos.z)
        )
        return false
    end

    -- clean input and parse coordinates
    param = param:gsub("%s+", "")
    local x, y, z = param:match("(%d+),(%d+),(%d+)")
    if not x or not y or not z then
        player:sendCancelMessage("Usage: /pos x,y,z")
        return false
    end

    -- validate target position
    local pos = Position(tonumber(x), tonumber(y), tonumber(z))
    if not Tile(pos) then
        player:sendCancelMessage("Invalid position or tile does not exist.")
        return false
    end

    -- teleport
    player:teleportTo(pos)
    pos:sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(
        MESSAGE_STATUS_CONSOLE_BLUE,
        string.format("Teleported to: %d, %d, %d.", pos.x, pos.y, pos.z)
    )
    return false
end

talk:separator(" ")
talk:register()

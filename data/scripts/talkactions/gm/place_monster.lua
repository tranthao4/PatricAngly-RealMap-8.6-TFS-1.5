local placeMonster = TalkAction("/m")

function placeMonster.onSay(player, words, param)
    local position = player:getPosition()
    local monster = Game.createMonster(param, position)
    if monster then
        monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        position:sendMagicEffect(CONST_ME_MAGIC_RED)
    else
        player:sendCancelMessage("There is not enough room.")
        position:sendMagicEffect(CONST_ME_POFF)
    end
    return false
end

placeMonster:separator(" ")
placeMonster:accountType(ACCOUNT_TYPE_GOD)
placeMonster:access(true)
placeMonster:register()


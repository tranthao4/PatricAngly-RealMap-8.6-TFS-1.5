local placeNpc = TalkAction("/s")

function placeNpc.onSay(player, words, param)
    local position = player:getPosition()
    local npc = Game.createNpc(param, position)
    if npc then
        npc:setMasterPos(position)
        position:sendMagicEffect(CONST_ME_MAGIC_RED)
    else
        player:sendCancelMessage("There is not enough room.")
        position:sendMagicEffect(CONST_ME_POFF)
    end
    return false
end

placeNpc:separator(" ")
placeNpc:accountType(ACCOUNT_TYPE_GOD)
placeNpc:access(true)
placeNpc:register()


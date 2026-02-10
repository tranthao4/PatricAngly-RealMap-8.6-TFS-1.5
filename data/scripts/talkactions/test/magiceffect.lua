local magiceffect = TalkAction("!z")

function magiceffect.onSay(player, words, param)
    local effect = tonumber(param)
    if (effect ~= nil and effect > 0) then
        player:getPosition():sendMagicEffect(effect)
    end

    return false
end

magiceffect:separator(" ")
magiceffect:access(true)
magiceffect:register()


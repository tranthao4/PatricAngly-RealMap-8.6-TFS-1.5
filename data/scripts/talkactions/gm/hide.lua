local hide = TalkAction("/hide")

function hide.onSay(player, words, param)
    player:setHiddenHealth(not player:isHealthHidden())
    return false
end

hide:access(true)
hide:register()


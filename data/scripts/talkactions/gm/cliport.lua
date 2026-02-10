local cliport = TalkAction("/cliport")

function cliport.onSay(player, words, param, type)
    local cliportCondition = player:getCondition(CONDITION_CLIPORT, CONDITIONID_DEFAULT)
    if cliportCondition then
        player:removeCondition(CONDITION_CLIPORT, CONDITIONID_DEFAULT)

        player:sendCancelMessage("You are no longer in cliport mode.")
    else
        cliportCondition = Condition(CONDITION_CLIPORT, CONDITIONID_DEFAULT)
        cliportCondition:setParameter(CONDITION_PARAM_TICKS, -1)
        player:addCondition(cliportCondition)

        player:sendCancelMessage("You are now in cliport mode.")

        local specs = nil
        if player:isInGhostMode() then
            local spectators = Game.getSpectators(player:getPosition(), true, true)
            specs = {}
            for _, spectator in ipairs(spectators) do
                if spectator:getGroup():getAccess() or spectator:getAccountType() >=
                    ACCOUNT_TYPE_GOD then specs[#specs + 1] = spectator end
            end
        end

        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT, specs)
    end
    return false
end

cliport:accountType(ACCOUNT_TYPE_GOD)
cliport:access(true)
cliport:register()


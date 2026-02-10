local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(180000)

local spell = Spell(SPELL_INSTANT)
spell:name("Creature Illusion")
spell:words("utevo res ina")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Master Sorcerer", "Elder Druid")
spell:level(23)
spell:mana(100)
spell:isAggressive(false)
spell:hasParams(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local returnValue = RETURNVALUE_NOERROR
	local monsterType = MonsterType(variant:getString())
	if not monsterType then
		returnValue = RETURNVALUE_CREATUREDOESNOTEXIST
	elseif not creature:hasFlag(PlayerFlag_CanIllusionAll) and
		not monsterType:isIllusionable() then
		returnValue = RETURNVALUE_NOTPOSSIBLE
	end

	if returnValue ~= RETURNVALUE_NOERROR then
		creature:sendCancelMessage(returnValue)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	condition:setOutfit(monsterType:getOutfit())
	creature:addCondition(condition)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

spell:register()


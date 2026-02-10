local spell = Spell(SPELL_INSTANT)
spell:name("Invite Subowners")
spell:words("aleta som")
spell:group("support")
spell:level(0)
spell:mana(0)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local house = creature:getTile():getHouse()
	if not house or not house:canEditAccessList(SUBOWNER_LIST, creature) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:setEditHouse(house, SUBOWNER_LIST)
	creature:sendHouseWindow(house, SUBOWNER_LIST)
	return true
end

spell:register()


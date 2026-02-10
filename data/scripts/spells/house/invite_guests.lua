local spell = Spell(SPELL_INSTANT)
spell:name("Invite Guests")
spell:words("aleta sio")
spell:group("support")
spell:level(0)
spell:mana(0)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local house = creature:getTile():getHouse()
	if not house or not house:canEditAccessList(GUEST_LIST, creature) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:setEditHouse(house, GUEST_LIST)
	creature:sendHouseWindow(house, GUEST_LIST)
	return true
end

spell:register()


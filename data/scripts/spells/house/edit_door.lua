local spell = Spell(SPELL_INSTANT)
spell:name("Edit Door")
spell:words("aleta grav")
spell:group("support")
spell:level(0)
spell:mana(0)
spell:isAggressive(false)
spell:needDirection(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local house = creature:getTile():getHouse()
	local doorId = house and house:getDoorIdByPosition(variant:getPosition())
	if not doorId or not house:canEditAccessList(doorId, creature) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:setEditHouse(house, doorId)
	creature:sendHouseWindow(house, doorId)
	return true
end

spell:register()


local spell = Spell(SPELL_INSTANT)
spell:name("Magic Rope")
spell:words("exani tera")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Paladin", "Knight", "Master Sorcerer", "Elder Druid", "Royal Paladin", "Elite Knight")
spell:level(9)
spell:mana(20)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_POFF)

	local tile = Tile(position)
	if not table.contains(ropeSpots, tile:getGround():getId()) and
		not tile:getItemById(14435) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	tile = Tile(position:moveUpstairs())
	if not tile then
		creature:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
		return false
	end

	creature:teleportTo(position, false)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

spell:register()


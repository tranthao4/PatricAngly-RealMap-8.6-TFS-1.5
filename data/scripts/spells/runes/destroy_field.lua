local spell = Spell(SPELL_RUNE)
spell:name("Destroy Field Rune")
spell:runeId(2261)
spell:group("support")
spell:cooldown(2000)
spell:isAggressive(false)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	local position = variant:getPosition()
	local tile = Tile(position)
	local field = tile and tile:getItemByType(ITEM_TYPE_MAGICFIELD)
	if field and table.contains(FIELDS, field:getId()) then
		field:remove()
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	return false
end

spell:register()


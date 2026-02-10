local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Arrow")
spell:words("exevo con")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(13)
spell:mana(100)
spell:soul(1)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2544, 10, CONST_ME_MAGIC_BLUE)
end

spell:register()


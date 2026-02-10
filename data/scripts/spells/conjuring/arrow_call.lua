local spell = Spell(SPELL_INSTANT)
spell:name("Arrow Call")
spell:words("exevo infir con")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(1)
spell:mana(10)
spell:soul(0)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 23839, 3, CONST_ME_MAGIC_BLUE)
end

spell:register()


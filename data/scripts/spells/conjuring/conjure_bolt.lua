local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Bolt")
spell:words("exevo con mort")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(17)
spell:mana(140)
spell:soul(2)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2543, 5, CONST_ME_MAGIC_BLUE)
end

spell:register()


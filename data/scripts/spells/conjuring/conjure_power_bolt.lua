local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Power Bolt")
spell:words("exevo con vis")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(59)
spell:mana(700)
spell:soul(4)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2547, 10, CONST_ME_MAGIC_BLUE)
end

spell:register()


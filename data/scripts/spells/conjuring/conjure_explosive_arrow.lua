local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Explosive Arrow")
spell:words("exevo con flam")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(25)
spell:mana(290)
spell:soul(3)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2546, 8, CONST_ME_MAGIC_BLUE)
end

spell:register()


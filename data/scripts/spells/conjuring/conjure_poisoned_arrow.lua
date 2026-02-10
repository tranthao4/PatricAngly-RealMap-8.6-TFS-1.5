local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Poisoned Arrow")
spell:words("exevo con pox")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(16)
spell:mana(130)
spell:soul(2)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2545, 7, CONST_ME_MAGIC_BLUE)
end

spell:register()


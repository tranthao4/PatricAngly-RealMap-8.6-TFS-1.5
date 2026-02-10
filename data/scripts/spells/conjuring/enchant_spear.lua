local spell = Spell(SPELL_INSTANT)
spell:name("Enchant Spear")
spell:words("exeta con")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(45)
spell:mana(350)
spell:soul(3)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(2389, 7367, 1, CONST_ME_MAGIC_GREEN)
end

spell:register()


local spell = Spell(SPELL_INSTANT)
spell:name("Enchant Staff")
spell:words("exeta vis")
spell:group("support")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(41)
spell:mana(80)
spell:soul(0)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(2401, 2433, 1, CONST_ME_MAGIC_GREEN)
end

spell:register()


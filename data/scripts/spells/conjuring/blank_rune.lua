local spell = Spell(SPELL_INSTANT)
spell:name("Blank Rune")
spell:words("adori blank")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Master Sorcerer", "Elder Druid")
spell:level(20)
spell:mana(20)
spell:soul(1)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 2260, 1)
end

spell:register()


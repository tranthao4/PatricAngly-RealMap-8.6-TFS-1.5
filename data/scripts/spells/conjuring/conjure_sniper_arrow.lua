local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Sniper Arrow")
spell:words("exevo con hur")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(24)
spell:mana(160)
spell:soul(3)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 7364, 5, CONST_ME_MAGIC_BLUE)
end

spell:register()


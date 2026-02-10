local spell = Spell(SPELL_INSTANT)
spell:name("Conjure Piercing Bolt")
spell:words("exevo con grav")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(33)
spell:mana(180)
spell:soul(3)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 7363, 5, CONST_ME_MAGIC_BLUE)
end

spell:register()


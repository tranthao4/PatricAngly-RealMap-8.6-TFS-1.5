local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local spell = Spell(SPELL_INSTANT)
spell:name("Cancel Invisibility")
spell:words("exana ina")
spell:group("support")
spell:vocation("Paladin", "Royal Paladin")
spell:level(26)
spell:mana(200)
spell:isPremium(true)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local spell = Spell(SPELL_INSTANT)
spell:name("Cure Poison")
spell:words("exana pox")
spell:group("healing")
spell:vocation("Sorcerer", "Druid", "Paladin", "Knight", "Master Sorcerer", "Elder Druid", "Royal Paladin", "Elite Knight")
spell:level(10)
spell:mana(30)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(6000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


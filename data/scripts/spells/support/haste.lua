local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 33000)
condition:setFormula(0.3, -24, 0.3, -24)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)
spell:name("Haste")
spell:words("utani hur")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Paladin", "Master Sorcerer", "Elder Druid", "Royal Paladin")
spell:level(14)
spell:mana(60)
spell:isPremium(true)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


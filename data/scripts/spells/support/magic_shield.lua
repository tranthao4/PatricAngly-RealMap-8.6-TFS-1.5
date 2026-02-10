local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, 200000)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)
spell:name("Magic Shield")
spell:words("utamo vita")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Master Sorcerer", "Elder Druid")
spell:level(14)
spell:mana(50)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


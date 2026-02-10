local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 10000)
condition:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 135)
condition:setParameter(CONDITION_PARAM_DISABLE_DEFENSE, true)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)
spell:name("Blood Rage")
spell:words("utito tempo")
spell:group("support")
spell:vocation("Knight", "Elite Knight")
spell:level(60)
spell:mana(290)
spell:isPremium(true)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


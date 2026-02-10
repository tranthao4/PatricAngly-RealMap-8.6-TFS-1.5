local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_LIGHT)
condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 6)
condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, 215)
condition:setParameter(CONDITION_PARAM_TICKS, (6 * 60 + 10) * 1000)
combat:addCondition(condition)

local spell = Spell(SPELL_INSTANT)
spell:name("Light")
spell:words("utevo lux")
spell:group("support")
spell:vocation("Sorcerer", "Druid", "Paladin", "Knight", "Master Sorcerer", "Elder Druid", "Royal Paladin", "Elite Knight")
spell:level(8)
spell:mana(20)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


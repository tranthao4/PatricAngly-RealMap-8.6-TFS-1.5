local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_FIST, 3)
condition:setParameter(CONDITION_PARAM_SKILL_MELEE, 3)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 3)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local spell = Spell(SPELL_INSTANT)
spell:name("Train Party")
spell:words("utito mas sio")
spell:group("support")
spell:vocation("Knight", "Elite Knight")
spell:level(32)
spell:mana(60)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:groupCooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:addPartyCondition(combat, variant, condition, 60)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local spell = Spell(SPELL_INSTANT)
spell:name("Enchant Party")
spell:words("utori mas sio")
spell:group("support")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(32)
spell:mana(120)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:groupCooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return creature:addPartyCondition(combat, variant, condition, 120)
end

spell:register()


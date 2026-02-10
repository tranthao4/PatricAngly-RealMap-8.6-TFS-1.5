local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:setFormula(-1, 80, -1, 80)
combat:addCondition(condition)

local spell = Spell(SPELL_RUNE)
spell:name("Paralyze Rune")
spell:runeId(2278)
spell:group("attack")
spell:cooldown(2000)
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	if not combat:execute(creature, variant) then return false end

	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local spell = Spell(SPELL_RUNE)
spell:name("Cure Poison Rune")
spell:runeId(2266)
spell:group("healing")
spell:cooldown(2000)
spell:isAggressive(false)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


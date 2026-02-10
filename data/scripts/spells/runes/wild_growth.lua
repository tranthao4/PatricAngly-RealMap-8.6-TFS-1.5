local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_WILDGROWTH)

local spell = Spell(SPELL_RUNE)
spell:name("Wild Growth Rune")
spell:runeId(2269)
spell:group("support")
spell:cooldown(2000)
spell:isAggressive(false)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local spell = Spell(SPELL_RUNE)
spell:name("Poison Bomb Rune")
spell:runeId(2286)
spell:group("attack")
spell:cooldown(2000)
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


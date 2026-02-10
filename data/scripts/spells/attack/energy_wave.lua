local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 4.5) + 20
	local max = (level / 5) + (magicLevel * 7.6) + 48
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Energy Wave")
spell:words("exevo vis hur")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(38)
spell:mana(170)
spell:needDirection(true)
spell:cooldown(8000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


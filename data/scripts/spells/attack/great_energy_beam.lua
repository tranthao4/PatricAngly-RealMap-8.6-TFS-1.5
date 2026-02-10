local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setArea(createCombatArea(AREA_BEAM8))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 3.6) + 22
	local max = (level / 5) + (magicLevel * 6) + 37
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Great Energy Beam")
spell:words("exevo gran vis lux")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(29)
spell:mana(110)
spell:needDirection(true)
spell:cooldown(6000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


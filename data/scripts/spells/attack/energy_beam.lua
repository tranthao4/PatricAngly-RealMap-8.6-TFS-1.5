local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setArea(createCombatArea(AREA_BEAM5, AREADIAGONAL_BEAM5))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.0) + 8
	local max = (level / 5) + (magicLevel * 1.8) + 14
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Energy Beam")
spell:words("exevo vis lux")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(23)
spell:mana(40)
spell:needDirection(true)
spell:cooldown(4000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 0.8) + 5
	local max = (level / 5) + (magicLevel * 1.6) + 10
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Energy Strike")
spell:words("exori vis")
spell:group("attack")
spell:vocation("Sorcerer", "Druid", "Master Sorcerer", "Elder Druid")
spell:level(12)
spell:mana(20)
spell:isPremium(true)
spell:range(3)
spell:blockWalls(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


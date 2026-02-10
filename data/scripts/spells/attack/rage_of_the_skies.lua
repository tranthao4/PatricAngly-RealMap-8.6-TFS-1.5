local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 4) + 75
	local max = (level / 5) + (magicLevel * 10) + 150
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Rage of the Skies")
spell:words("exevo gran mas vis")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(55)
spell:mana(600)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(40000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


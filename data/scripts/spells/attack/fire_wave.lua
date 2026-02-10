local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setArea(createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.2) + 7
	local max = (level / 5) + (magicLevel * 2) + 12
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Fire Wave")
spell:words("exevo flam hur")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(18)
spell:mana(25)
spell:needDirection(true)
spell:cooldown(4000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


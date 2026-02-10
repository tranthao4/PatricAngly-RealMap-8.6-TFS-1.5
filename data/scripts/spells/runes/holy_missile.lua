local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.8) + 11
	local max = (level / 5) + (magicLevel * 3.8) + 23
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_RUNE)
spell:name("Holy Missile Rune")
spell:runeId(2295)
spell:group("attack")
spell:cooldown(2000)
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

local function callback(player, level, magicLevel)
	level = math.min(level, 20)
	magicLevel = math.min(magicLevel, 20)
	local min = (level / 5) + (magicLevel * 0.45) + 3
	local max = (level / 5) + (magicLevel * 0.7) + 4
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_RUNE)
spell:name("Lightest Missile Rune")
spell:runeId(7958)
spell:group("attack")
spell:cooldown(2000)
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


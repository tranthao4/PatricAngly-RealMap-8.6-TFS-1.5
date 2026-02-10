local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 0.5) + 3
	local max = (level / 5) + (magicLevel * 1.0) + 6
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Divine Missile")
spell:words("exori san")
spell:group("attack")
spell:vocation("Paladin", "Royal Paladin")
spell:level(40)
spell:mana(20)
spell:isPremium(true)
spell:range(4)
spell:blockWalls(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


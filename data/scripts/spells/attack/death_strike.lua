local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 0.8) + 5
	local max = (level / 5) + (magicLevel * 1.6) + 10
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Death Strike")
spell:words("exori mort")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(16)
spell:mana(20)
spell:isPremium(true)
spell:range(3)
spell:isSelfTarget(false)
spell:blockWalls(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


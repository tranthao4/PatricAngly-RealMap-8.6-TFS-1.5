local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 3) + 20
	local max = (level / 5) + (magicLevel * 5) + 40
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Divine Caldera")
spell:words("exevo mas san")
spell:group("attack")
spell:vocation("Paladin", "Royal Paladin")
spell:level(50)
spell:mana(160)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(4000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


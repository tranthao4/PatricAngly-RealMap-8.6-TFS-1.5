local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 8) + 50
	local max = (level / 5) + (magicLevel * 12) + 75
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Hell's Core")
spell:words("exevo gran mas flam")
spell:group("attack")
spell:vocation("Sorcerer", "Master Sorcerer")
spell:level(60)
spell:mana(1100)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(40000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 1.4) + 8
	local max = (level / 5) + (magicLevel * 1.8) + 11
	return min, max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Light Healing")
spell:words("exura")
spell:group("healing")
spell:vocation("Sorcerer", "Druid", "Paladin", "Master Sorcerer", "Elder Druid", "Royal Paladin")
spell:level(8)
spell:mana(20)
spell:isAggressive(false)
spell:isSelfTarget(true)
spell:cooldown(1000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


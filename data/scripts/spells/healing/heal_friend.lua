local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 6.3) + 45
	local max = (level / 5) + (magicLevel * 14.4) + 90
	return min, max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Heal Friend")
spell:words("exura sio")
spell:group("healing")
spell:vocation("Druid", "Elder Druid")
spell:level(18)
spell:mana(140)
spell:isPremium(true)
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(true)
spell:hasPlayerNameParam(true)
spell:hasParams(true)
spell:cooldown(1000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return combat:execute(creature, variant)
end

spell:register()


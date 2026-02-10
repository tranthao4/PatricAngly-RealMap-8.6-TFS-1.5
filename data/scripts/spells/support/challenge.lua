local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local function callback(creature, target)
	return doChallengeCreature(creature, target)
end

combat:setCallback(CallBackParam.TARGETCREATURE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Challenge")
spell:words("exeta res")
spell:group("support")
spell:vocation("Elite Knight")
spell:level(20)
spell:mana(30)
spell:isPremium(true)
spell:isAggressive(false)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


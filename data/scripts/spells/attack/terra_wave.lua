local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

local function callback(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 3.25) + 5
	local max = (level / 5) + (magicLevel * 6.75) + 30
	return -min, -max
end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Terra Wave")
spell:words("exevo tera hur")
spell:group("attack")
spell:vocation("Druid", "Elder Druid")
spell:level(38)
spell:mana(210)
spell:needDirection(true)
spell:cooldown(4000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


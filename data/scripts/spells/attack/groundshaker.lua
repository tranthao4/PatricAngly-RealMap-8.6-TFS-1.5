local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local function callback(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.02) + 4
	local max = (player:getLevel() / 5) + (skill * attack * 0.03) + 6
	return -min, -max
end

combat:setCallback(CallBackParam.SKILLVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Groundshaker")
spell:words("exori mas")
spell:group("attack")
spell:vocation("Knight", "Elite Knight")
spell:level(33)
spell:mana(160)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(8000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


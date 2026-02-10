local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)

local function callback(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.01) + 1
	local max = (player:getLevel() / 5) + (skill * attack * 0.03) + 6
	return -min, -max
end

combat:setCallback(CallBackParam.SKILLVALUE, callback)

local spell = Spell(SPELL_INSTANT)
spell:name("Whirlwind Throw")
spell:words("exori hur")
spell:group("attack")
spell:vocation("Knight", "Elite Knight")
spell:level(28)
spell:mana(40)
spell:isPremium(true)
spell:range(5)
spell:needTarget(true)
spell:blockWalls(true)
spell:needWeapon(true)
spell:cooldown(6000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:register()


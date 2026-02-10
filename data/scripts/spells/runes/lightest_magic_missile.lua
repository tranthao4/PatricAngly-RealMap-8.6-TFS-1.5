local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

local function callback(player, level, magicLevel) return -3, -7 end

combat:setCallback(CallBackParam.LEVELMAGICVALUE, callback)

local spell = Spell(SPELL_RUNE)
spell:name("Lightest Magic Missile Rune")
spell:runeId(7956)
spell:group("attack")
spell:cooldown(2000)
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:register()


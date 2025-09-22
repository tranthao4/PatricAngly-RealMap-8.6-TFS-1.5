local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(20, 9000, -10)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

local arr = {
  {0, 1, 0, 1, 0},
  {1, 1, 1, 1, 1},
  {0, 1, 2, 1, 0},
  {1, 1, 1, 1, 1},
  {0, 1, 0, 1, 0}
}

local area = createCombatArea(arr)
combat:setArea(area)
combat:addCondition(condition)

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

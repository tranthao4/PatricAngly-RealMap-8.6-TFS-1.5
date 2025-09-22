local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, 70)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)

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

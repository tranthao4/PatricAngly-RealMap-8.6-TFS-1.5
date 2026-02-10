local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(200000)

local spell = Spell(SPELL_INSTANT)
spell:name("Chameleon")
spell:words("adevo ina")
spell:group("support")
spell:vocation("Druid", "Elder Druid")
spell:level(27)
spell:mana(100)
spell:isPremium(true)
spell:isAggressive(false)
spell:needTarget(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant, isHotkey)
	local position, item = variant:getPosition()
	if position.x == CONTAINER_POSITION then
		local container = creature:getContainerById(position.y - 64)
		if container then
			item = container:getItem(position.z)
		else
			item = creature:getSlotItem(position.y)
		end
	else
		item = Tile(position):getTopDownItem()
	end

	if not item or item.itemid == 0 or not isMoveable(item.uid) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	condition:setOutfit({lookTypeEx = item.itemid})
	creature:addCondition(condition)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
end

spell:register()


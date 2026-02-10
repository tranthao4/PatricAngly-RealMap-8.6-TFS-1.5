local spell = Spell(SPELL_INSTANT)
spell:name("Kick Guest")
spell:words("alana sio")
spell:group("support")
spell:level(0)
spell:mana(0)
spell:isAggressive(false)
spell:hasParams(true)
spell:cooldown(2000)
spell:needLearn(false)

function spell.onCastSpell(creature, variant)
	local target = Player(variant:getString()) or creature
	local house = target:getTile():getHouse()
	if not house or not house:kickPlayer(creature, target) then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	return true
end

spell:register()


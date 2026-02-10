function onSay(player, words, param)
	local town = Town(param)
	if not town then
		town = Town(tonumber(param))
	end

	if town then
		player:teleportTo(town:getTemplePosition())
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleported to " .. town:getName() .. ".")
	else
		player:sendCancelMessage("Town not found.")
	end
	return false
end

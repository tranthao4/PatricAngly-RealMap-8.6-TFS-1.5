local playerLogout = CreatureEvent("PlayerLogout")
playerLogout:type("logout")

function playerLogout.onLogout(player)
	local playerId = player:getId()
	nextUseStaminaTime[playerId] = nil
	return true
end

playerLogout:register()


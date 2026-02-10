local playerRecord = GlobalEvent("PlayerRecord")
playerRecord:type("record")

function playerRecord.onRecord(current, old)
	addEvent(Game.broadcastMessage, 150,
	         "New record: " .. current .. " players are logged in.",
	         MESSAGE_STATUS_DEFAULT)
	return true
end

playerRecord:register()


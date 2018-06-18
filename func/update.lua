local update = {}

function update.update(delta)
	if status.check("menu") then
		update.menu()
	elseif status.check("load") then
		update.load()
	elseif status.check("game") then
		update.game(delta)
	end
end

function update.game(delta)
	player.move("BEN1JEN", delta)
	local playerX, playerY = player.getPosition("BEN1JEN")
	local offsetX, offsetY = zoom.offset()
	camera.jump(playerX - offsetX, playerY - offsetY)
end

function update.menu()
	ui.update()
	if ui.button.isDown(id.get("btn-quit")) then
		love.event.quit()
	elseif ui.button.isDown(id.get("btn-play")) then
		ui.button.delete(id.get("btn-play"))
		ui.button.delete(id.get("btn-quit"))
		status.change("game")
	end
end

function update.load()
	load.update()
end

return update

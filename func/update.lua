local update = {}

function update.update()
	if status.check("menu") then
		update.menu()
	elseif status.check("load") then
		update.load()
	elseif status.check("game") then
		update.game()
	end
end

function update.game()

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

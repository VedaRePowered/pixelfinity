local update = {}
local inventoryDownLast = false

function update.update(delta)
	if button.fullscreen() then
		love.window.setFullscreen( not love.window.getFullscreen() )
	end
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
	if bool.get("inventory-open") then
		inventory.update(player.getInventory("BEN1JEN"))
		local craftingInvs = player.getCrafting("BEN1JEN")
		inventory.update(craftingInvs["in"])
		inventory.update(craftingInvs.out)
		if craftingInvs["in"].changed then
			craftingInvs.out = crafting.craft(craftingInvs["in"], 2, 2)
			inventory.resetChange(craftingInvs["in"])
		end
		if craftingInvs.out.changed then
			crafting.removeSupplies(craftingInvs["in"], craftingInvs.out.changed.name)
			craftingInvs.out = crafting.craft(craftingInvs["in"], 2, 2)
			inventory.resetChange(craftingInvs.out)
		end
	else
		worldInteraction.update()
	end
	if button.inventory() then
		bool.toggle("inventory-open")
	end
	if button.debug() then
		bool.toggle("debug-open")
	end
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

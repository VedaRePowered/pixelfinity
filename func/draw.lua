local draw = {}

function draw.draw()
	if status.check("load") then
		draw.load()
	elseif status.check("menu") then
		draw.menu()
	elseif status.check("game") then
		draw.game()
	end
	ui.draw()
end

function draw.game()
	draw.world()
	draw.player()
	inventory.drawHotbar(player.getInventory("BEN1JEN")[1])
	if bool.get("inventory-open") then
		inventory.draw(player.getInventory("BEN1JEN"))
		inventory.drawItemGrabed()
	end
end

function draw.load()
	local width, height = love.window.getMode()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(asset.get("logo"), width/2-347, 150)
end

function draw.menu()
	local width, height = love.window.getMode()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(asset.get("logo"), width/2-347, 150)
	if not motd then
		motd = misc.randLine("motd.txt")
	end
	love.graphics.setFont(asset.getFont("regular"))
	love.graphics.print(motd, 0, 0)
end

function draw.world()
	local camX, camY = camera.getPos()
	for yOffset = 1, zoom.yBlocks()+2 do
		for xOffset = -1, zoom.xBlocks()+1 do
			block.drawBlock(worldFunc.get(math.floor(xOffset+camX), math.floor(yOffset+camY)), (xOffset - misc.fpart(camX))*zoom.blockSize(), (yOffset - misc.fpart(camY))*zoom.blockSize())
		end
	end
end

function draw.player()
	local playerX, playerY = player.getPosition("BEN1JEN")
	local camX, camY = camera.getPos()
	local _, height = love.window.getMode()
	playerX, playerY = playerX - camX, playerY - camY
	love.graphics.rectangle("fill", playerX*zoom.blockSize(), height-playerY*zoom.blockSize(), zoom.blockSize() * 0.75, zoom.blockSize())
end

return draw

local draw = {}

function draw.draw()
	if status.check("load") then
		draw.load()
	elseif status.check("menu") then
		draw.menu()
	elseif status.check("game") then
		draw.world()
	end
	ui.draw()
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
	love.graphics.print(motd, 0, 0)
end

function draw.world()
	local camX, camY = camera.getPos()
	for yOffset = 0, zoom.yBlocks()+1 do
		for xOffset = 0, zoom.xBlocks() do
			block.drawBlock(worldFunc.get(math.floor(xOffset+camX), math.floor(yOffset+camY)), xOffset*zoom.blockSize(), yOffset*zoom.blockSize())
		end
	end
end

return draw

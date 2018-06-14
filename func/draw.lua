local draw = {}

function draw.draw()
	if status.check("load") then
		draw.load()
	elseif status.check("menu") then
		draw.menu()
	end
	ui.draw()
end

function draw.load()
	local width, height = love.window.getMode()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(logo, width/2-347, 150)
end

function draw.menu()
	local width, height = love.window.getMode()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(logo, width/2-347, 150)
	if not motd then
		motd = misc.randLine("motd.txt")
	end
	love.graphics.print(motd, 0, 0)
end

return draw

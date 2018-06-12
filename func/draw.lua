local draw = {}

function draw.draw()
	if status.check("menu") then
		draw.menu()
		ui.draw()
	end
end

function draw.menu()
	local width, height = love.window.getMode()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(logo, width/2-347, 150)
end

return draw


function love.load()
	misc   = require "func.misc"
	load   = require "func.load"
	status = require "func.status"
	draw   = require "func.draw"
	lui    = require "lui.index"

	logo = love.graphics.newImage("assets/logo.png")

	ui = lui()

	load.init()
end

function love.update(delta)
	load.update()
end

function love.draw()
	draw.draw()
end

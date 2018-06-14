
function love.load()

	-- os.time and math.randomseed
	local startTime = os.time()
	math.randomseed(os.time())

	misc   = require "func.misc"
	load   = require "func.load"
	block  = require "func.block"
	asset  = require "func.asset"
	status = require "func.status"
	draw   = require "func.draw"
	lui    = require "lui.index"

	ui = lui()

	load.init()
end

function love.update(delta)
	load.update()
end

function love.draw()
	draw.draw()
end

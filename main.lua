
function love.load()

	-- os.time and math.randomseed
	local startTime = os.time()
	math.randomseed(os.time())

	misc      = require "func.misc"
	load      = require "func.load"
	block     = require "func.block"
	asset     = require "func.asset"
	status    = require "func.status"
	id        = require "func.id"
	bool      = require "func.bool"
	zoom      = require "func.zoom"
	camera    = require "func.camera"
	draw      = require "func.draw"
	update    = require "func.update"
	worldFunc = require "func.world"
	collision = require "func.collision"
	gui       = require "func.gui"
	button    = require "func.button"
	player    = require "func.player"
	item      = require "func.item"
	timer     = require "func.timer"
	inventory = require "func.inventory"
	worldInteraction= require "func.worldInteraction" 
	lui       = require "lui.index"

	ui = lui()

	load.init()
end

function love.update(delta)
	update.update(delta)
end

function love.draw()
	draw.draw()
end

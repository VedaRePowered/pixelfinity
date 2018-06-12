local load = {}
local progress = "loadAssets"
local bar1, bar2, bar3

local assets = {}

function load.init()
	local width, height = love.window.getMode()
	bar1 = ui.progress.newBar(width/4, 300, width/2, 50, {0.95, 0.7, 0.17})
	bar2 = ui.progress.newBar(width/4, 400, width/2, 50)
	bar3 = ui.progress.newBar(width/4, 500, width/2, 50, {0.09, 0.21, 1})
end

function load.update()
	if progress == "initalyze" then
		
	elseif progress == "loadAssets" then
		load.assets()
	elseif progress == "declareBlocks" then
	elseif progress == "declareItems" then
	end
end

function load.assets()

end

return load

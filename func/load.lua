local load = {}
local progress1, progress2 = "loadAssets", 1
local bar1, bar2

function load.init()
	logo = love.graphics.newImage("assets/logo.png")
	local width, height = love.window.getMode()
	bar1 = ui.progress.newBar(width/4, 300, width/2, 50, {0.95, 0.07, 0.17})
	bar2 = ui.progress.newBar(width/4, 400, width/2, 50, {0.19, 0.31, 1})
	ui.button.newButtonTexture("minicraftButton", font)
end

function load.update()
	if progress1 == "initalyze" then
		ui.progress.setProgress(bar1, 0)
	elseif progress1 == "loadAssets" then
		load.assets()
		ui.progress.setProgress(bar1, 0.25)
	elseif progress1 == "declareBlocks" then
		load.blocks()
		ui.progress.setProgress(bar1, 0.5)
	elseif progress1 == "declareItems" then
		progress1 = "done"
		ui.progress.setProgress(bar1, 0.75)
	elseif progress1 == "done" then
		load.complete()
	end

end

function load.assets()
	local a = block.getDeclaringBlocks()[progress2]
	if a then
		asset.load(a[1], "blocks/" .. a[1])
		progress2 = progress2 + 1
	else
		progress1 = "declareBlocks"
	end
	ui.progress.setProgress(bar2, (progress2-1)/#block.getDeclaringBlocks())
end

function load.blocks()
	local a = block.getDeclaringBlocks()[progress2]
	if a then
		block.declareBlock(a[1], asset.get(a[1]), a[2], a[3], a[4])
		progress2 = progress2 + 1
	else
		progress1 = "declareItems"
	end
	ui.progress.setProgress(bar2, (progress2-1)/#block.getDeclaringBlocks())
end

function load.complete()
	ui.progress.delete(bar1)
	ui.progress.delete(bar2)
	status.change("menu")
	ui.button.newButton()
end

return load

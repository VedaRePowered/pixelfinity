local load = {}
local progress1, progress2 = "loadAssets", 1

function load.init()
	asset.load("logo", "logo")
	local width, height = love.window.getMode()
	id.new( "bar-load-1", ui.progress.newBar(width/4, 300, width/2, 50, {0.95, 0.07, 0.17}) )
	id.new( "bar-load-2", ui.progress.newBar(width/4, 400, width/2, 50, {0.19, 0.31, 1}) )
	id.new( "tex-main", ui.button.newButtonTexture("minicraftButton", asset.newFont("big", "menlo.ttf", 32)) )
end

function load.update()
	if progress1 == "initalyze" then
		ui.progress.setProgress(id.get("bar-load-1"), 0)
	elseif progress1 == "loadAssets" then
		load.assets()
		ui.progress.setProgress(id.get("bar-load-1"), 0.25)
	elseif progress1 == "declareBlocks" then
		load.blocks()
		ui.progress.setProgress(id.get("bar-load-1"), 0.5)
	elseif progress1 == "declareItems" then
		progress1 = "done"
		ui.progress.setProgress(id.get("bar-load-1"), 0.75)
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
		progress2 = 1
	end
	ui.progress.setProgress(id.get("bar-load-2"), (progress2-1)/#block.getDeclaringBlocks())
end

function load.blocks()
	local a = block.getDeclaringBlocks()[progress2]
	if a then
		block.declareBlock(a[1], asset.get(a[1]), a[2], a[3], a[4])
		progress2 = progress2 + 1
	else
		progress1 = "declareItems"
	end
	ui.progress.setProgress(id.get("bar-load-2"), (progress2-1)/#block.getDeclaringBlocks())
end

function load.complete()
	ui.progress.delete(id.get("bar-load-1"))
	ui.progress.delete(id.get("bar-load-2"))
	status.change("menu")
	local width, height = love.window.getMode()
	id.new( "btn-play", ui.button.newButton(width/4, 300, "Play", id.get("tex-main"), {0.95, 0.2, 0.6}, width/2) )
	id.new( "btn-quit", ui.button.newButton(width/4, 400, "Quit", id.get("tex-main"), {0.95, 0.2, 0.6}, width/2) )
end

return load

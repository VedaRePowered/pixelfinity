local load = {}
local progress1, progress2 = "initalyze", 1
local boolsToDeclare = {
	"inventory-open",
	"up-down-last",
	"inventory-down-last",
	"hotbar-0-down-last",
	"hotbar-1-down-last",
	"hotbar-2-down-last",
	"hotbar-3-down-last",
	"hotbar-4-down-last",
	"hotbar-5-down-last",
	"hotbar-6-down-last",
	"hotbar-7-down-last",
	"hotbar-8-down-last",
	"hotbar-9-down-last"
}

function load.init()
	asset.load("logo", "logo")
	local width, height = love.window.getMode()
	id.new( "bar-load-1", ui.progress.newBar(width/4, 300, width/2, 50, {0.95, 0.07, 0.17}) )
	id.new( "bar-load-2", ui.progress.newBar(width/4, 400, width/2, 50, {0.19, 0.31, 1}) )
	id.new( "tex-main", ui.button.newButtonTexture("minicraftButton", asset.newFont("big", "menlo.ttf", 32)) )
	asset.newFont("regular", "menlo.ttf", 18)
end

function load.update()
	if progress1 == "initalyze" then
		player.new("BEN1JEN", 0, 220, inventory.fill(10, 5))
		ui.progress.setProgress(id.get("bar-load-1"), 0)
		progress1 = "loadAssets"
	elseif progress1 == "loadAssets" then
		load.assets()
		ui.progress.setProgress(id.get("bar-load-1"), 0.2)
	elseif progress1 == "declareBlocks" then
		load.blocks()
		ui.progress.setProgress(id.get("bar-load-1"), 0.4)
	elseif progress1 == "declareItems" then
		load.items()
		ui.progress.setProgress(id.get("bar-load-1"), 0.6)
	elseif progress1 == "declareBools" then
		load.bools()
		ui.progress.setProgress(id.get("bar-load-1"), 0.8)
	elseif progress1 == "done" then
		load.complete()
	end

end

function load.assets()
	local a = block.getDeclaringBlocks()[progress2]
	local b = item.getDeclaringItems()[progress2-#block.getDeclaringBlocks()]
	local c = asset.getDeclaringAssets()[progress2-#block.getDeclaringBlocks()-#item.getDeclaringItems()]
	if a then
		asset.load(a[1], "blocks/" .. a[1])
		progress2 = progress2 + 1
	elseif b then
		asset.load(b[1], b[2])
		progress2 = progress2 + 1
	elseif c then
		asset.load(c, c)
		progress2 = progress2 + 1
	else
		progress1 = "declareBlocks"
		progress2 = 1
	end
	ui.progress.setProgress( id.get("bar-load-2"), (progress2-1)/(#block.getDeclaringBlocks()+#item.getDeclaringItems()+#asset.getDeclaringAssets()) )
end

function load.blocks()
	local a = block.getDeclaringBlocks()[progress2]
	if a then
		block.declareBlock(a[1], asset.get(a[1]), a[2], a[3], a[4], a[5])
		progress2 = progress2 + 1
	else
		progress1 = "declareItems"
		progress2 = 1
	end
	ui.progress.setProgress(id.get("bar-load-2"), (progress2-1)/#block.getDeclaringBlocks())
end

function load.bools()
	local a = boolsToDeclare[progress2]
	if a then
		bool.new(a, false)
		progress2 = progress2 + 1
	else
		progress1 = "done"
	end
	ui.progress.setProgress(id.get("bar-load-2"), (progress2-1)/#boolsToDeclare)
end

function load.items()
	local a = item.getDeclaringItems()[progress2]
	if a then
		item.declareItem(a[1], asset.get(a[1]), a[3], a[4])
		progress2 = progress2 + 1
	else
		progress1 = "declareBools"
		progress2 = 1
	end
	ui.progress.setProgress(id.get("bar-load-2"), (progress2-1)/#item.getDeclaringItems())
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

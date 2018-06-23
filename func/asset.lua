local asset = {}
local images = {}
local fonts = {}

function asset.load(name, file)
	if love.filesystem.getInfo("assets/" .. file .. ".png") then
		images[name] = love.graphics.newImage("assets/" .. file .. ".png")
	else
		misc.warn("asset: file assets/" .. file .. ".png does not exist, using default texture")
		images[name] = love.graphics.newImage("assets/missing.png")
	end
	images[name]:setFilter("nearest")
end

function asset.get(name)
	return images[name]
end

function asset.newFont(name, file, size)
	fonts[name] = love.graphics.newFont("assets/" .. file, size)
	return fonts[name]
end

function asset.getFont(name)
	return fonts[name]
end

function asset.getDeclaringAssets()
	return {
		"inventorySlot",
		"hotbarSlot",
		"break1",
		"break2",
		"break3",
		"break4",
		"break5",
		"break6"
	}
end

return asset

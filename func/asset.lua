local asset = {}
local images = {}
local fonts = {}

function asset.load(name, file)
	images[name] = love.graphics.newImage("assets/" .. file .. ".png")
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

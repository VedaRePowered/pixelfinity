local asset = {}
local images = {}

function asset.load(name, file)
	images[name] = love.graphics.newImage("assets/" .. file .. ".png")
end

function asset.get(name)
	return images[name]
end

return asset

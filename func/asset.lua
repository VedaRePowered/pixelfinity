local asset = {}
local images = {}

function asset.load(name, file)
	images[name] = love.graphics.newImage(file)
end

return asset

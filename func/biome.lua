biome = {}
biomes = require "assets/biomes"

function biome.get(name)
	return biomes[name]
end

function biome.getHeights(x, bio, seed)
	local heights = {}
	for layer, levels in ipairs(bio.blockPerlinLevels) do
		local height = bio.layerMinHeights[layer]
		if heights[#heights] then
			height = height + heights[#heights]
		end
		for i, perlinLevel in ipairs(levels) do
			height = height + math.floor(love.math.noise(x/perlinLevel.smoothness, seed+i+layer*10)*perlinLevel.intensity)
		end
		table.insert(heights, height)
	end
	return heights
end

return biome

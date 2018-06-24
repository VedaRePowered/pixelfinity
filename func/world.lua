local worldFunc = {}
local world = {}
local seed = 13

function worldFunc.set(x, y, block, waterLevel)
	x = math.floor(x)
	y = math.floor(y)
	if not world[x] then
		world[x] = {}
	end
	if not world[x][y] then
		world[x][y] = {}
	end
	if block then
		world[x][y]["block"] = block
	end
	if waterLevel then
		world[x][y]["waterLevel"] = waterLevel
	end
end

function worldFunc.get(x, y)
	x, y = math.floor(x), math.floor(y)

	local ret
	if not x then
		misc.warn("world: getting block at x = nil is impossible")
	end
	if not y then
		misc.warn("world: getting block at y = nil is impossible")
	end
	if not world[x] then
		worldFunc.gen(x)
	end

	if world[x][y] then
		ret = world[x][y]["block"]
	else
		misc.warn("world: y = " .. y .. " is out of bounds")
	end

	return ret
end

function worldFunc.gen(x)
	world[x] = {}
	local bio = biome.get("plains")
	local heights = biome.getHeights(x, bio, seed)
	local topLayer = heights[#heights] + 1
	for y = 1, 1024 do
		worldFunc.set(x, y, "air")
		if y == 1 then
			worldFunc.set(x, y, "zerostone")
		else
			worldFunc.set(x, y, "air")
			if y <= topLayer then
				for i, height in ipairs(heights) do
					if y <= height then
						worldFunc.set(x, y, bio.blockNames[i])
						break
					end
				end
				if y == topLayer and bio.topLayer then
					worldFunc.set(x, y, bio.topLayer)
				end
			end
		end
	end
	if bio.structures.trees and math.random(1, bio.structures.trees.chance) == 1 then
		worldFunc.set(x, topLayer, "dirt")
		worldFunc.tree("oak", x, topLayer)
	end
end

function worldFunc.tree(type, x, y)
	if type == "oak" then
		worldFunc.get(x-2, 1)
		worldFunc.get(x-1, 1)
		worldFunc.get(x+1, 1)
		worldFunc.get(x+2, 1)
		local yTree = math.random(5, 7)
		for yOffset = 1, yTree do
			worldFunc.set(x, y+yOffset, "oaklog")
		end
		worldFunc.set(x-2, y+yTree-2, "oakleavs")
		worldFunc.set(x-1, y+yTree-2, "oakleavs")
		worldFunc.set(x+1, y+yTree-2, "oakleavs")
		worldFunc.set(x+2, y+yTree-2, "oakleavs")
		worldFunc.set(x-2, y+yTree-1, "oakleavs")
		worldFunc.set(x-1, y+yTree-1, "oakleavs")
		worldFunc.set(x+1, y+yTree-1, "oakleavs")
		worldFunc.set(x+2, y+yTree-1, "oakleavs")
		worldFunc.set(x-2, y+yTree, "oakleavs")
		worldFunc.set(x-1, y+yTree, "oakleavs")
		worldFunc.set(x, y+yTree, "oakleavs")
		worldFunc.set(x+1, y+yTree, "oakleavs")
		worldFunc.set(x+2, y+yTree, "oakleavs")
		worldFunc.set(x-1, y+yTree+1, "oakleavs")
		worldFunc.set(x, y+yTree+1, "oakleavs")
		worldFunc.set(x+1, y+yTree+1, "oakleavs")
		worldFunc.set(x-1, y+yTree+2, "oakleavs")
		worldFunc.set(x, y+yTree+2, "oakleavs")
		worldFunc.set(x+1, y+yTree+2, "oakleavs")
	end
end

return worldFunc

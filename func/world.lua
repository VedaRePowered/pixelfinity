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
	for y = 1, 1024 do
		local sHeight = math.floor(love.math.noise(x/100, seed)*100)+200
		local dHeight = math.floor(love.math.noise(x/10, seed)*2)+2
		if y == 1 then
			worldFunc.set(x, y, "zerostone")
		elseif y < sHeight then
			worldFunc.set(x, y, "stone")
		elseif y < sHeight+4 then
			worldFunc.set(x, y, "dirt")
		elseif y == sHeight+4 then
			worldFunc.set(x, y, "grass")
		else
			worldFunc.set(x, y, "air")
		end
	end
end

return worldFunc

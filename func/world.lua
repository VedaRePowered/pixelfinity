local worldFunc = {}
local world = {}

function worldFunc.get(x, y)
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
		ret = world[x][y]
	else
		misc.warn("world: y = " .. y .. " is out of bounds")
	end

	return ret
end

function worldFunc.gen(x)
	world[x] = {}
	for y = 1, 1024 do
		if y == 1 then
			world[x][y] = "zerostone"
		elseif y < 256 then
			world[x][y] = "stone"
		elseif y < 260 then
			world[x][y] = "dirt"
		elseif y == 260 then
			world[x][y] = "grass"
		else
			world[x][y] = "air"
		end
	end
end

return worldFunc

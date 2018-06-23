local block = {}
local blocks = {}

function block.declareBlock(name, texture, type, hardness, drops, intangable)
	blocks[name] = {texture=texture, type=type, hardness=hardness, drops=drops, intangable=intangable}
end

function block.getDeclaringBlocks()
	return {
		{ "air", "", false, {}, true },
		{ "zerostone", "", false, {}, false },
		{ "oaklog", "wood", 1, {{item="oaklogblock", chance=1, amount=1, withtool=true}, {item="oakplank", chance=1, amount=2}, {item="oakplank", chance=0.5, amount=2}}, false },
		{ "oakleavs", "wood", 0.2, {{item="oakleavsblock", chance=1, amount=1, withtool=true}, {item="oaksaplingblock", chance=0.1, amount=1}}, false },
		{ "oaksapling", "wood", 0, {{item="oaksaplingblock", chance=1, amount=1}}, true },
		{ "oakwood", "wood", 0.5, {{item="oakplank", chance=1, amount=2}, {item="oakplank", chance=0.5, amount=2}}, false },
		{ "stone", "rock", 2.5, {{item="cobblestoneblock", chance=1, amount=1, withtool=true}}, false },
		{ "cobblestone", "rock", 2, {{item="cobblestoneblock", chance=1, amount=1, withtool=true}}, false },
		{ "dirt", "dirt", 0.8, {{item="dirtblock", chance=1, amount=1}}, false },
		{ "grass", "dirt", 1, {{item="dirtblock", chance=1, amount=1}, {item="grass", chance=1, amount=1, withtool=true}}, false },
		{ "clay", "dirt", 0.8, {{item="clay", chance=1, amount=2}, {item="clay", chance=0.5, amount=2}}, false }
	}
end

function block.drawBlock(name, x, y)
	local _, height = love.window.getMode()
	if blocks[name] then
		love.graphics.draw(blocks[name]["texture"], x, height-y, 0, zoom.getLevel(), zoom.getLevel())
	else
		if name then
			misc.warn("block: block " .. name .. " does not exist")
		else
			misc.warn("block: cannot draw nil block")
		end
	end
end

function block.get(name)
	return blocks[name]
end

return block

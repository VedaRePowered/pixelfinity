local block = {}
local blocks = {}

function block.declareBlock(name, texture, type, hardness, drops, intangable)
	blocks[name] = {texture=texture, type=type, hardness=hardness, drops=drops, intangable=intangable}
end

function block.getDeclaringBlocks()
	return {
		{ "air", "", false, {}, true },
		{ "zerostone", "", false, {} },
		{ "oaklog", "wood", 3, {{item="oaklogblock", chance=1, ammount=1, withtool=true}, {item="oakplank", chance=1, ammount=2}, {item="oakplank", chance=0.5, ammount=2}} },
		{ "oakleavs", "wood", 1, {{item="oakleavsblock", chance=1, ammount=1, withtool=true}, {item="oaksaplingblock", chance=0.1, ammount=1}} },
		{ "oakwood", "wood", 2, {{item="oakplank", chance=1, ammount=2}, {item="oakplank", chance=0.5, ammount=2}} },
		{ "stone", "rock", 5, {{item="cobblestoneblock", chance=1, ammount=1, withtool=true}} },
		{ "cobblestone", "rock", 4, {{item="cobblestoneblock", chance=1, ammount=1, withtool=true}} },
		{ "dirt", "dirt", 2, {{item="dirtblock", chance=1, ammount=1}} },
		{ "grass", "grass", 3, {{item="dirtblock", chance=1, ammount=1}, {item="grass", chance=1, ammount=1, withtool=true}} }
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

return block

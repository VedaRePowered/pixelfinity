local block = {}
local blocks = {}

function block.declareBlock(name, texture, type, hardness, drops)
	blocks[name] = {texture=texture, type=type, hardness=hardness, drops=drops}
end

function block.getDeclaringBlocks()
	return {
		{ "zerostone", "", math.huge, {} },
		{ "oaklog", "wood", 3, {{item="oaklogblock", chance=1, ammount=1, withtool=true}, {item="oakplank", chance=1, ammount=2}, {item="oakplank", chance=0.5, ammount=2}} },
		{ "oakleavs", "wood", 1, {{item="oakleavsblock", chance=1, ammount=1, withtool=true}, {item="oaksaplingblock", chance=0.1, ammount=1}} },
		{ "oakwood", "wood", 2, {{item="oakplank", chance=1, ammount=2}, {item="oakplank", chance=0.5, ammount=2}} },
		{ "stone", "rock", 5, {{item="cobblestoneblock", chance=1, ammount=1, withtool=true}} },
		{ "cobblestone", "rock", 4, {{item="cobblestoneblock", chance=1, ammount=1, withtool=true}} },
		{ "dirt", "dirt", 2, {{item="dirtblock", chance=1, ammount=1}} },
		{ "grass", "grass", 3, {{item="dirtblock", chance=1, ammount=1}, {item="grass", chance=1, ammount=1, withtool=true}} }
	}
end

return block

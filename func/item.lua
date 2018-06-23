local item = {}
local items = {}

function item.declareItem(name, texture, displayName, toolFor, mineMul, useFunc, useArg)
	items[name] = {texture=texture, useFunc=useFunc, useArg=useArg, toolFor=toolFor, mineMul=mineMul, displayName=displayName}
end

function item.getDeclaringItems()
	local ret = {}

	for i, decBlock in ipairs(block.getDeclaringBlocks()) do
		table.insert(ret, {decBlock[1] .. "block", "blocks/" .. decBlock[1], decBlock[1] .. " Block", {}, 1, worldInteraction.placeItem, decBlock[1]})
	end

	table.insert(ret, {"clay", "items/clay", "Clay", {}, 1, false})
	table.insert(ret, {"oakplank", "items/oakplank", "Oak Plank", {}, 1, false})
	table.insert(ret, {"ultraminer", "blocks/zerostone", "Ultra Miner", {"wood", "rock", "dirt", "leavs"}, 50, worldInteraction.placeItem, "dirt"})
	table.insert(ret, {"stonepickaxe", "items/stonepickaxe", "Stone Pickaxe", {"rock"}, 2, false})
	table.insert(ret, {"stoneaxe", "items/stoneaxe", "Stone Axe", {"wood"}, 5, false})
	table.insert(ret, {"stoneshovel", "items/stoneshovel", "Stone Shovel", {"dirt"}, 3, false})
	table.insert(ret, {"ironpickaxe", "items/ironpickaxe", "Iron Pickaxe", {"rock"}, 6, false})
	table.insert(ret, {"ironaxe", "items/ironaxe", "Iron Axe", {"wood"}, 8, false})
	table.insert(ret, {"ironshovel", "items/ironshovel", "Iron Shovel", {"dirt"}, 8, false})
	table.insert(ret, {"grass", "items/grass", "Tall Grass", {}, 1, false})

	return ret
end

function item.drawItem(name, x, y)
	local _, height = love.window.getMode()
	if items[name] then
		love.graphics.draw(items[name]["texture"], x, height-y, 0, gui.getScale(), gui.getScale())
	else
		if name then
			misc.warn("item: item " .. name .. " does not exist")
		else
			misc.warn("item: cannot draw nil item")
		end
	end
end

function item.get(name)
	return items[name]
end

function item.isToolFor(name, blockType)
	for i, toolType in ipairs(items[name]["toolFor"]) do
		if blockType == toolType then
			return true
		end
	end
	return false
end

return item

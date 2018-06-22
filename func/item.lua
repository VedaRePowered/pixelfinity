local item = {}
local items = {}

function item.declareItem(name, texture, useFunc, useArg)
	items[name] = {texture=texture, useFunc=useFunc, useArg=useArg}
end

function item.getDeclaringItems()
	local ret = {}

	for i, decBlock in ipairs(block.getDeclaringBlocks()) do
		table.insert(ret, {decBlock[1] .. "block", "blocks/" .. decBlock[1], worldInteraction.placeItem, decBlock[1]})
	end

	table.insert(ret, {"clay", "items/clay", false})
	table.insert(ret, {"oakplank", "items/oakplank", false})
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

return item

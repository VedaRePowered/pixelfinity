local worldInteraction = {}
local blockBeingBroken = {x = 1, y = 1}
local hotbar = 1

-- convert mouse x, y to block x, y
function worldInteraction.mouseToBlock()
	local _, height = love.window.getMode()
	local camX, camY = camera.getPos()
	local mouseX, mouseY = love.mouse.getPosition()

	mouseY = height - mouseY
	local blockX = mouseX/zoom.blockSize() + camX
	local blockY = mouseY/zoom.blockSize() + camY + 1
	return blockX, blockY
end

-- update block breaking
function worldInteraction.update()
	-- if the player is clocking on a block, then
	if button.breakBlock() then
		local blockX, blockY = worldInteraction.mouseToBlock()
		local blockX, blockY = math.floor(blockX), math.floor(blockY)
		if blockBeingBroken.x ~= blockX or blockBeingBroken.y ~= blockY then
			timer.reset("breaking-timer")
		end
		blockBeingBroken = {x=blockX, y=blockY}
	else

		timer.new("breaking-timer")
	end

	for i = 1, 10 do
		if button["hotbar" .. i]() then
			hotbar = i
		end
	end

	local hardness = block.get(worldFunc.get(blockBeingBroken.x, blockBeingBroken.y)).hardness

	local inv = player.getInventory("BEN1JEN")
	local name = inventory.getName(inv, hotbar, 1)
	local isTool = false
	local breakingBlock = worldFunc.get(blockBeingBroken.x, blockBeingBroken.y)
	if name ~= "" then
		isTool = item.isToolFor(name, block.get(breakingBlock).type)
	end

	if isTool then
		hardness = hardness / item.get(name).mineMul
	end

	if hardness and hardness <= timer.getTime("breaking-timer") then
		timer.reset("breaking-timer")
		if blockBeingBroken.y > 0 then
			worldInteraction.dropBlock(breakingBlock, inv, isTool)
			worldFunc.set(blockBeingBroken.x, blockBeingBroken.y, "air")
		end
	end

	if button.use() then
		local selectedItem, i = inventory.get(player.getInventory("BEN1JEN"), hotbar, 1)
		if selectedItem and selectedItem.useFunc then
			selectedItem.useFunc(selectedItem.useArg, player.getInventory("BEN1JEN"), hotbar, 1)
		end
	end

end

function worldInteraction.draw()
	local _, height = love.window.getMode()
	local blockX, blockY = blockBeingBroken.x, blockBeingBroken.y
	local camX, camY = camera.getPos()
	local hardness = block.get(worldFunc.get(blockBeingBroken.x, blockBeingBroken.y)).hardness
	local breakAmount = 0
	if hardness then
		breakAmount = math.floor(timer.getTime("breaking-timer")/hardness * 6 + 0.5)
	end

	if breakAmount < 0 or breakAmount > 6 then
		misc.warn("worldInteraction: breakAmount is out of bounds (" .. breakAmount .. ")")
		breakAmount = 6
	end
	if breakAmount > 0 then
		love.graphics.draw(asset.get("break" .. breakAmount), (blockX - camX)*zoom.blockSize(), height-((blockY - camY)*zoom.blockSize()), 0, zoom.getLevel(), zoom.getLevel())
	end
end

function worldInteraction.dropBlock(name, inv, tool)
	local drops = block.get(name).drops
	for _, drop in ipairs(drops) do
		if not drop.withtool or tool then
			if math.random(1, math.ceil(1/drop.chance)) == 1 then
				inventory.give(inv, drop.item, drop.amount)
			end
		end
	end
end

function worldInteraction.getHotbarSelect()
	return hotbar
end

function worldInteraction.placeItem(name, inv, x, y)
	local blockX, blockY = worldInteraction.mouseToBlock()
	if worldFunc.get(blockX, blockY) == "air" then
		worldFunc.set(blockX, blockY, name)
		inventory.take(inv, x, y)
	end
end

return worldInteraction

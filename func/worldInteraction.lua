local worldInteraction = {}
local blockBeingBroken = {x = 0, y = 0}

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

	local hardness = block.get(worldFunc.get(blockBeingBroken.x, blockBeingBroken.y)).hardness

	if hardness and hardness <= timer.getTime("breaking-timer") then
		timer.reset("breaking-timer")
		local blockX, blockY = worldInteraction.mouseToBlock()
		local blockX, blockY = math.floor(blockX), math.floor(blockY)
		if blockY > 0 then
			worldInteraction.dropBlock(worldFunc.get(blockX, blockY), player.getInventory("BEN1JEN"))
			worldFunc.set(blockX, blockY, "air")
		end
	end
end

function worldInteraction.draw()
	local _, height = love.window.getMode()
	local blockX, blockY = blockBeingBroken.x, blockBeingBroken.y
	local camX, camY = camera.getPos()
	love.graphics.print(misc.prettyNumber(timer.getTime("breaking-timer")), (blockX - camX)*zoom.blockSize(), height-((blockY - camY)*zoom.blockSize()))
end

function worldInteraction.dropBlock(name, inv)
	local drops = block.get(name).drops
	for _, drop in ipairs(drops) do
		if not drop.withtool then
			if math.random(1, 1/drop.chance) == 1 then
				inventory.give(inv, drop.item, drop.amount)
			end
		end
	end
end

return worldInteraction

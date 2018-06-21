local worldInteraction = {}

function worldInteraction.mouseToBlock()

end

function worldInteraction.update()

end

function worldInteraction.draw()

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

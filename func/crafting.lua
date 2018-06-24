crafting = {}
recipes = require "assets/recipes"

function crafting.craft(inputInventory, outputX, outputY)
	local amounts = crafting.getAmounts(inputInventory)
	local outputInventory = inventory.fill(outputX, outputY, true, 300, 500)
	for _, recipe in ipairs(recipes) do
		recipePossible = true
		for i, inputItem in ipairs(recipe) do
			local name, amount = inputItem.name, inputItem.amount
			if amounts[name] then
				if amounts[name] < amount then
					recipePossible = false
				end
			else
				recipePossible = false
			end
		end
		if recipePossible then
			inventory.give(outputInventory, recipe.out.name, recipe.out.amount)
		end
	end

	return outputInventory
end

function crafting.getAmounts(inv)
	local amounts = {}
	width, height = inventory.getSize(inv)
	for x = 1, width do
		for y = 1, height do
			itemSlot = inventory.getSlot(inv, x, y)
			name, amount = itemSlot.name, itemSlot.amount
			if amount ~= 0 then
				if not amounts[name] then
					amounts[name] = amount
				else
					amounts[name] = amounts[name] + amount
				end
			end
			
		end
	end
	return amounts
end

function crafting.removeSupplies(inv, name)
	for _, recipe in ipairs(recipes) do
		if recipe.out.name == name then
			for _, takeItem in ipairs(recipe) do
				inventory.searchTake(inv, takeItem.name, takeItem.amount)
			end
		end
	end
end

return crafting


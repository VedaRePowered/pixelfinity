local inventory = {}
local itemGrabed = {name="", amount=0}
local mouseDownLast = 0
local dragedPastSlots = {}

function inventory.drawItemGrabed()
	local mouseX, mouseY = love.mouse.getPosition()
	local _, height = love.window.getMode()

	mouseX = mouseX - gui.getScale()*8
	mouseY = height - mouseY + gui.getScale()*8
	if itemGrabed.amount ~= 0 then
		item.drawItem(itemGrabed.name, mouseX, mouseY)
		if itemGrabed.amount > 0 then
			love.graphics.setFont(asset.getFont("regular"))
			love.graphics.print(itemGrabed.amount, mouseX, height-mouseY)
		end
	end
end

function inventory.draw(inv)
	-- get the height of the screen, and the gui scale
	local guiZoom = gui.getScale()*20
	local _, height = love.window.getMode()

	-- loop thrugh all slots in the inventory
	for yOffset, row in ipairs(inv) do
		for xOffset, itemData in ipairs(row) do
			-- draw a slot in the inventory
			love.graphics.draw(asset.get("inventorySlot"), inv.x+xOffset*guiZoom-2*gui.getScale(), height-(inv.y+yOffset*guiZoom+2*gui.getScale()), 0, gui.getScale(), gui.getScale())
			if itemData.amount ~= 0 then
				-- if there's an item here, draw it
				item.drawItem(itemData.name, inv.x+xOffset*guiZoom, inv.y+yOffset*guiZoom)
				if itemData.amount > 0 then
					love.graphics.setFont(asset.getFont("regular"))
					love.graphics.print(itemData.amount, inv.x+xOffset*guiZoom, height-(inv.y+yOffset*guiZoom))
				end
			end
			if inv.sx == xOffset and inv.sy == yOffset then
				-- highlight the selected slot
				love.graphics.setColor(1, 1, 1, 0.3)
				love.graphics.rectangle("fill", inv.x+xOffset*guiZoom, height-(inv.y+yOffset*guiZoom), gui.getScale()*16, gui.getScale()*16)
				love.graphics.setColor(1, 1, 1, 1)
			end
			if inventory.containsInventorySlot(dragedPastSlots, xOffset, yOffset) then
				-- highlight the draged past slot
				love.graphics.setColor(1, 1, 0.3, 0.4)
				love.graphics.rectangle("fill", inv.x+xOffset*guiZoom, height-(inv.y+yOffset*guiZoom), gui.getScale()*16, gui.getScale()*16)
				love.graphics.setColor(1, 1, 1, 1)
			end
		end
	end
end

function inventory.fill(w, h) -- create a new empty inventory with a specific size
	local ret = {}
	ret.x, ret.y, ret.sx, ret.sy = 50, 50, 3, 1
	for y = 1, h do
		ret[y] = {}
		for x = 1, w do
			if x == 1 then
				ret[y][x] = {name="grassblock", amount=5}
			elseif x == 2 then
				ret[y][x] = {name="clay", amount=5}
			else
				ret[y][x] = {name="", amount=0}
			end
		end
	end
	return ret
end

function inventory.update(inv) -- update a specific inventory
	-- set important variables for the function
	local _, height = love.window.getMode()
	local mouseX, mouseY = love.mouse.getPosition()
	mouseY = height-mouseY

	if mouseX > inv.x and mouseY > inv.y then
		-- if the mouse is inside the inventory, select the right item
		mouseX, mouseY = mouseX-inv.x+2*gui.getScale(), mouseY-inv.y-2*gui.getScale()
		inv.sx = math.floor(mouseX/gui.getScale()/20)
		inv.sy = math.ceil(mouseY/gui.getScale()/20)
	else
		-- if the mouse is outside of the inventory on -x or -y, deselect all items
		inv.sx, inv.sy = 0, 0
	end

	-- if the mouse is outside of the inventory on +x or +y, deselect all items
	if inv.sy > #inv or inv.sx > #inv[1] then
		inv.sx, inv.sy = 0, 0
	end

	-- if they have let go, and are inside of the inventory then do somthing with the items
	if not love.mouse.isDown(1, 2) and inv.sx ~= 0 then
		-- if they haven't dragedPastSlots do one of these 2 item opporations
		if #dragedPastSlots <= 1 then
			-- if the 1st button was pressed, and the items are diferent, then swap the items
			if mouseDownLast == 1 and itemGrabed.name ~= inv[inv.sy][inv.sx]["name"] then
				local tmp = itemGrabed
				itemGrabed = inv[inv.sy][inv.sx]
				inv[inv.sy][inv.sx] = tmp
				mouseDownLast = 0
			end
			-- if the 1st button was pressed, and the items the same, then add the items together
			if mouseDownLast == 1 and itemGrabed.name == inv[inv.sy][inv.sx]["name"] then
				inv[inv.sy][inv.sx].amount = inv[inv.sy][inv.sx].amount + itemGrabed.amount
				itemGrabed = {name = "", amount = 0}
				mouseDownLast = 0
			end
			-- if the 2nd button was pressed, and thare is no item in the grabbed slot, split the selected slot
			if mouseDownLast == 2 and itemGrabed.amount == 0 then
				itemGrabed.name = inv[inv.sy][inv.sx]["name"]
				itemGrabed.amount = inv[inv.sy][inv.sx]["amount"]
				inv[inv.sy][inv.sx]["amount"] = math.floor(inv[inv.sy][inv.sx]["amount"] / 2)
				itemGrabed.amount = math.ceil(itemGrabed.amount / 2)
				mouseDownLast = 0
			end
			-- if the 2nd button was pressed, and thare is the same item in the grabbed slot and the selected, split the selected slot
			if mouseDownLast == 2 and ( ( itemGrabed.name == inv[inv.sy][inv.sx]["name"] or inv[inv.sy][inv.sx]["amount"] == 0 ) and itemGrabed.amount > 0 ) then
				itemGrabed.amount = itemGrabed.amount - 1
				inv[inv.sy][inv.sx]["amount"] = inv[inv.sy][inv.sx]["amount"] + 1
				inv[inv.sy][inv.sx]["name"] = itemGrabed.name
				if itemGrabed.amount == 0 then
					itemGrabed.name = ""
				end
				mouseDownLast = 0
			end
		elseif itemGrabed.amount > 0 then -- otherwise do a multi-item opporation if they have an item grabed
			-- calculate slots to be added to
			local addToSlots = {}
			for _, slot in ipairs(dragedPastSlots) do
				if inv[slot.y][slot.x]["name"] == itemGrabed.name or inv[slot.y][slot.x]["amount"] == 0 then
					table.insert(addToSlots, slot)
				end
			end
			-- if left click, do drag spliting
			if mouseDownLast == 1 then
				local amountToAdd = math.floor(itemGrabed.amount/#addToSlots)
				for _, slot in ipairs(addToSlots) do
					inv[slot.y][slot.x]["name"] = itemGrabed.name
					inv[slot.y][slot.x]["amount"] = inv[slot.y][slot.x]["amount"] + amountToAdd
				end
				itemGrabed.amount = itemGrabed.amount % #addToSlots
			end
			-- if right click, do drag adding
			if mouseDownLast == 2 then
				for i, slot in ipairs(addToSlots) do
					if i <= #itemGrabed.amount then
						inv[slot.y][slot.x]["name"] = itemGrabed.name
						inv[slot.y][slot.x]["amount"] = inv[slot.y][slot.x]["amount"] + 1
					end
				end
				itemGrabed.amount = math.max(itemGrabed.amount - #addToSlots, 0)
			end
		end

		-- reset the slots draged past if the mouse was released
		dragedPastSlots = {}
	end

	if love.mouse.isDown(1, 2) and inv.sx ~= 0 then
		if not inventory.containsInventorySlot(dragedPastSlots, inv.sx, inv.sy) then
			table.insert(dragedPastSlots, {x=inv.sx, y=inv.sy})
		end
	end

	mouseDownLast = 0

	-- mark if the 1st button is down
	if love.mouse.isDown(1) then
		mouseDownLast = 1
	end

	-- mark if the 2nd button is down
	if love.mouse.isDown(2) then
		mouseDownLast = 2
	end

	for i = 1, 10 do
		if button["hotbar" .. i]() then
			local tmp = inv[1][i]
			inv[1][i] = inv[inv.sy][inv.sx]
			inv[inv.sy][inv.sx] = tmp
			mouseDownLast = 0
		end
	end

end

function inventory.containsInventorySlot(table, x, y)
	for _, item in pairs(table) do
		if item.x == x and item.y == y then
			return true
		end
	end
	return false
end

return inventory

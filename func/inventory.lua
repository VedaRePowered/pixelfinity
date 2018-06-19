local inventory = {}
local itemGrabed = {name="", amount=0}
local mouseDownLast = 0

function inventory.drawItemGrabed()
	local mouseX, mouseY = love.mouse.getPosition()
	local _, height = love.window.getMode()

	mouseY = height - mouseY
	if itemGrabed.amount ~= 0 then
		item.drawItem(itemGrabed.name, mouseX, mouseY)
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
				-- highlight the selected item
				love.graphics.setColor(1, 1, 1, 0.3)
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
		-- if the mouse is outside of the inventory, deselect all items
		inv.sx = 0
	end

	-- if they have let go, and are inside of the inventory, then do somthing with the items
	if not love.mouse.isDown(1, 2) and inv.sx ~= 0 then
		-- if the 1st button was pressed, then swap the items
		if mouseDownLast == 1 then
			local tmp = itemGrabed
			itemGrabed = inv[inv.sy][inv.sx]
			inv[inv.sy][inv.sx] = tmp
		end
		-- if the 2nd button was pressed, and thare is no item in the grabbed slot, split the selected slot
		if mouseDownLast == 2 and itemGrabed.amount == 0 then
			inv[inv.sy][inv.sx]["amount"] = math.floor(inv[inv.sy][inv.sx]["amount"] / 2)
			itemGrabed.name = inv[inv.sy][inv.sx]["name"]
			itemGrabed.amount = inv[inv.sy][inv.sx]["amount"] + 1
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


end

return inventory

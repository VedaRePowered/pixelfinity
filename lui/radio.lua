function create(mouse)
	local radio = {}
	local buttonSets = {}

	function radio.newButtonSet(x, y, buttons)

		buttonSets[#buttonSets+1] = {x=x, y=y, buttons=buttons, selected=1}

		return #buttonSets
	end

	function radio.updateRadioSelectors(delta)

		local mouseX, mouseY, mouseD = mouse.get()

		if mouseD then
			for id, set in ipairs(buttonSets) do
				if mouseX > set.x-8 and mouseX < set.x+8 and mouseY > set.y-8 and mouseY < set.y+#set.buttons*20-12 then
					set.selected = math.floor((mouseY-set.y+30)/20)
				end
			end
		end

	end

	function radio.drawButnSets()

		for id, set in ipairs(buttonSets) do
			for i, btn in ipairs(set.buttons) do
				love.graphics.setColor(1, 1, 1)
				love.graphics.circle("fill", set.x, set.y+i*20-20, 8)
				love.graphics.print(btn, set.x+10, set.y+i*20-30)
			end
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.circle("fill", set.x, set.y+set.selected*20-20, 6)
		end

	end

	function radio.getSelectedID(id)

		return buttonSets[id]["selected"]

	end

	function radio.getSelected(id)

		return buttonSets[id]["buttons"][buttonSets[id]["selected"]]

	end

	return radio
end

return create

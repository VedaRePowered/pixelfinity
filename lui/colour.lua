function create(mouse)

	local colour = {}
	local colourPickers = {}

	function colour.newPicker(x, y)

		colourPickers[#colourPickers+1] = {x=x, y=y, colour={0.95, 0.7, 0.4}, mode="RGB"}

		return #colourPickers
	end

	function colour.getColour(id)

		return colourPickers[id]["colour"]

	end

	function colour.updateColoursPicked()

		for id, clr in ipairs(colourPickers) do
			clr.colour = colour["updateMode"][clr.mode](clr.x, clr.y+10, clr.colour)
		end

	end

	function colour.drawColours()

		for id, clr in ipairs(colourPickers) do
			colour["drawMode"][clr.mode](clr.x, clr.y+10, clr.colour)
		end

	end

	colour.updateMode = {}

	function colour.updateMode.RGB(x, y, colour)
		local mouseX, mouseY, mouseD = mouse.get()

		if mouseD and mouseY > y+10 and mouseY < y+110 then
			if mouseX > x+10 and mouseX < x+20 then
				colour[1] = 1-(mouseY-y-10)/100
			end
			if mouseX > x+30 and mouseX < x+40 then
				colour[2] = 1-(mouseY-y-10)/100
			end
			if mouseX > x+50 and mouseX < x+60 then
				colour[3] = 1-(mouseY-y-10)/100
			end
		end
		return colour
	end

	colour.drawMode = {}

	function colour.drawMode.RGB(x, y, pickedColour)

		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", x, y, 90, 120)
		love.graphics.setColor(pickedColour[1], 0, 0)
		love.graphics.rectangle("fill", x+10, y+10, 10, 100)
		love.graphics.setColor(0, pickedColour[2], 0)
		love.graphics.rectangle("fill", x+30, y+10, 10, 100)
		love.graphics.setColor(0, 0, pickedColour[3])
		love.graphics.rectangle("fill", x+50, y+10, 10, 100)
		love.graphics.setColor(pickedColour)
		love.graphics.rectangle("fill", x+70, y+10, 10, 100)

		love.graphics.setColor(0, 0, 0, 0.5)
		love.graphics.rectangle("fill", x+45, y+8+(1-pickedColour[3])*100, 20, 4)
		love.graphics.rectangle("fill", x+25, y+8+(1-pickedColour[2])*100, 20, 4)
		love.graphics.rectangle("fill", x+05, y+8+(1-pickedColour[1])*100, 20, 4)

	end

	function colour.delete(id)
		colourPickers[id] = nil
	end

	return colour

end

return create

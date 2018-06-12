function create(mouse)

	local slider = {}
	local sliders = {}

	function slider.newSlider(x, y, length, colour, upright, min, max)

		if not colour then
			colour = {1, 1, 1}
		end
		if not min then
			min = 0
		end
		if not max then
			max = 1
		end

		sliders[#sliders+1] = {x=x, y=y, colour=colour, upright=upright, pos=min, min=min, max=max, grabbed=false, length=length}

		return #sliders
	end

	function slider.updatePositions(delta)

		local mouseX, mouseY, mouseD, mouseND = mouse.get()
		for id, sld in ipairs(sliders) do
			local position = (sld.pos/(sld.max-sld.min)*(sld.length-14))+2
			if not sld.grabbed then
				if mouseND and mouseX > sld.x+position and mouseX < sld.x+position+10 and mouseY > sld.y+2 and mouseY < sld.y+27 then
					sld.grabbed = true
				end
			else
				if not mouseD then
					sld.grabbed = false
				end

				sld.pos = (mouseX - sld.x) / sld.length * (sld.max-sld.min)

				if sld.pos >= sld.max then
					sld.pos = sld.max
				elseif sld.pos <= sld.min then
					sld.pos = sld.min
				end
			end
		end

	end

	function slider.drawSliders()

		for id, sld in ipairs(sliders) do
			love.graphics.setColor(sld["colour"][1]/2, sld["colour"][2]/2, sld["colour"][3]/2)
			love.graphics.rectangle("fill", sld.x, sld.y, sld.length, 25)
			love.graphics.setColor(sld.colour)
			if sld.grabbed then
				love.graphics.setColor(sld["colour"][1]*0.1, sld["colour"][2]*0.1, sld["colour"][3]*0.1)
			end
			love.graphics.rectangle("fill", sld.x+(sld.pos/(sld.max-sld.min)*(sld.length-14))+2, sld.y+2, 10, 21)
		end

	end

	function slider.getPosition(id)

		return sliders[id]["pos"]

	end

	return slider
end

return create

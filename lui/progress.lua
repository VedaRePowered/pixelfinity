function create()

	local progress = {}
	local progressBars = {}

	function progress.newBar(x, y, width, height, colour, vertical)

		if not height then
			height = 25
		end
		if not colour then
			colour = {0.02, 1, 0.06}
		end
		progressBars[#progressBars+1] = {x=x, y=y, width=width, height=height, colour=colour, vertical=vertical, progress=0}

		return #progressBars
	end

	function progress.drawPBars()

		for id, bar in ipairs(progressBars) do

			local w, h = bar.width, bar.height
			if bar.vertical then
				local t = h
				h = w
				w = t
			end

			love.graphics.setColor(bar["colour"][1]+0.8, bar["colour"][2]+0.8, bar["colour"][3]+0.8)
			love.graphics.rectangle("fill", bar.x, bar.y, w, h)

			local w, h = bar.progress*(bar.width-4), bar.height-4
			if bar.vertical then
				local t = h
				h = w
				w = t
			end

			love.graphics.setColor(bar["colour"][1]*0.95, bar["colour"][2]*0.95, bar["colour"][3]*0.95)
			love.graphics.rectangle("fill", bar.x+2, bar.y+2, w, h)
		end

	end

	function progress.setProgress(id, progress)

		progressBars[id]["progress"] = progress

	end

	return progress

end

return create

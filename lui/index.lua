function create()

	local lui = {}

	local button = require "lui.button"
	local slider = require "lui.slider"
	local checkbox = require "lui.checkbox"
	local progress = require "lui.progress"
	local radio = require "lui.radio"
	local colour = require "lui.colour"
	local mouse = require "lui.mouse"

	local screenWidth, screenHeight = love.graphics.getDimensions()

	lui.mouse = mouse(0, 0, screenWidth, screenHeight)
	lui.button = button(lui.mouse)
	lui.slider = slider(lui.mouse)
	lui.checkbox = checkbox(lui.mouse)
	lui.progress = progress()
	lui.radio = radio(lui.mouse)
	lui.colour = colour(lui.mouse)

	function lui.update(canvas)

		love.graphics.setCanvas(canvas)
			lui.mouse.updatePositionAndDown()
			lui.button.updateAreDowns()
			lui.slider.updatePositions()
			lui.checkbox.updateHaveBeenChecked()
			lui.radio.updateRadioSelectors()
			lui.colour.updateColoursPicked()
		love.graphics.setCanvas()

	end

	function lui.draw()

		lui.button.drawButtons()
		lui.slider.drawSliders()
		lui.checkbox.drawBoxes()
		lui.progress.drawPBars()
		lui.radio.drawButnSets()
		lui.colour.drawColours()

	end

	return lui
end

return create

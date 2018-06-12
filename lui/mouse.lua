function create(x, y, width, height)
	local mouse = {}
	local screenWidth, screenHeight = love.graphics.getDimensions()
	local translate = {x=x, y=y, width=width, height=height}
	local mouseX, mouseY = 0, 0
	local mouseVX, mouseVY = 0, 0
	local mouseDown = false
	local mouseDownLast = false

	function mouse.reTranslate(x, y, width, height)
		translate.x, translate.y, translate.width, translate.height = x, y, width, height
	end

	function mouse.updatePositionAndDown(delta)

		local mouseOldX, mouseOldY = mouseX, mouseY
		mouseDownLast = mouseDown

		
		mouseX, mouseY = love.mouse.getPosition()
		mouseDown = love.mouse.isDown(1)

		mouseX = mouseX/screenWidth *translate.width -translate.x
		mouseY = mouseY/screenHeight*translate.height-translate.y

		if not (mouseX > translate.x and mouseX < translate.x + translate.width and mouseY > translate.y and mouseY < translate.y + translate.height) then
			mouseX, mouseY, mouseDown = 0, 0, false
		end

		mouseVX, mouseVY = mouseX - mouseOldX, mouseY - mouseOldY

	end

	function mouse.get()

		return mouseX, mouseY, mouseDown, mouseDown and not mouseDownLast, not mouseDown and mouseDownLast, mouseVX, mouseVY, mouseDownLast

	end

	function mouse.getPosition()

		return mouseX, mouseY, mouseVX, mouseVY

	end

	function mouse.getVelocity()

		return mouseVX, mouseVY

	end

	function mouse.getDown()

		return mouseDown, mouseDownLast

	end

	function mouse.getChange()

		return mouseDown and not mouseDownLast, not mouseDown and mouseDownLast

	end

	return mouse
end

return create

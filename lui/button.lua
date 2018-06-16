function create(mouse)

	local button = {}
	local buttons = {}

	function button.newButtonTexture(imageFile, font)

		local texture = {}
		texture.image = love.graphics.newImage("lui/assets/" .. imageFile .. ".bmp")
		texture.image:setFilter("nearest")

		texture.xRes, texture.yRes = texture.image:getDimensions()
		texture.xRes = texture.xRes / 3
		texture.yRes = texture.yRes / 3

		texture.xScale = math.floor(16/texture.xRes)
		texture.yScale = math.floor(16/texture.yRes)

		texture.tl = love.graphics.newQuad(0, 0, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.tc = love.graphics.newQuad(texture.xRes, 0, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.tr = love.graphics.newQuad(texture.xRes * 2, 0, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.ml = love.graphics.newQuad(0, texture.yRes, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.mc = love.graphics.newQuad(texture.xRes, texture.yRes, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.mr = love.graphics.newQuad(texture.xRes * 2, texture.yRes, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.bl = love.graphics.newQuad(0, texture.yRes * 2, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.bc = love.graphics.newQuad(texture.xRes, texture.yRes * 2, texture.xRes, texture.yRes, texture.image:getDimensions())
		texture.br = love.graphics.newQuad(texture.xRes * 2, texture.yRes * 2, texture.xRes, texture.yRes, texture.image:getDimensions())

		texture.font = font

		return texture

	end

	function button.newButton(btnX, btnY, text, texture, colour, width, height)

		local id = #buttons + 1
		local btn = {x=btnX, y=btnY, width=math.ceil(texture.font:getWidth(text)/8+1)*8, height=math.ceil(texture.font:getHeight(text)/8+1)*8, pressed=false}

		if width then
			btn.width = width
		end
		if height then
			btn.height = height
		end

		height, width = btn.width/8, btn.width/8-2

		local canvas = love.graphics.newCanvas(btn.width, btn.height)
		love.graphics.setCanvas(canvas)

		love.graphics.setColor(1, 1, 1, 1)

		for y = 0, height do

			local left, center, right
			if y == 0 then
				left, center, right = texture.tl, texture.tc, texture.tr
			elseif y == height-1 then
				left, center, right = texture.bl, texture.bc, texture.br
			else
				left, center, right = texture.ml, texture.mc, texture.mr
			end

			love.graphics.draw(texture.image, left, 0, y*8, 0, texture.xScale/2, texture.yScale/2)
			for x = 1, width do
				love.graphics.draw(texture.image, center, 8*x, 8*y, 0, texture.xScale/2, texture.yScale/2)
			end
			love.graphics.draw(texture.image, right, width*8, y*8, 0, texture.xScale/2, texture.yScale/2)

		end

		love.graphics.setColor(colour)
		love.graphics.setFont(texture.font)
		love.graphics.print(text, 8, 4)

		love.graphics.setCanvas()
		btn["canvas"] = canvas

		buttons[id] = btn

		return id

	end

	function button.updateAreDowns(delta)
		local mouseX, mouseY, mouseD = mouse.get()

		for id, btn in ipairs(buttons) do
			if mouseD and mouseX >= btn.x and mouseX <= btn.x + btn.width and mouseY >= btn.y and mouseY <= btn.y+btn.height then
				btn.pressed = true
			else
				btn.pressed = false
			end
		end

	end

	function button.drawButtons()
		love.graphics.setBlendMode("alpha", "premultiplied")
		for id, btn in ipairs(buttons) do
			if btn.pressed then
				love.graphics.setColor(0.5, 0.5, 0.5)
			else
				love.graphics.setColor(1, 1, 1)
			end

			love.graphics.draw(btn.canvas, btn.x, btn.y)
		end
		love.graphics.setBlendMode("alpha")
	end

	function button.isDown(id)

		return buttons[id]["pressed"]

	end

	function button.delete(id)
		buttons[id] = nil
	end

	return button

end

return create

local camera = {}
local camX, camY = 0, 250

function camera.goto(x, y)
	camX, camY = x, y
end

function camera.move(x, y)
	camX, camY = camX + x, camY + y
end

function camera.getPos()
	return camX, camY
end

return camera

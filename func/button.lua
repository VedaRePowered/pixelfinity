local button = {}
local upDownLast = false

function button.up()
	local upRaw = love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("space")
	local ret = upRaw and not upDownLast
	upDownLast = upRaw
	return ret
end
function button.down()
	return love.keyboard.isDown("s") or love.keyboard.isDown("down")
end
function button.right()
	return love.keyboard.isDown("d") or love.keyboard.isDown("right")
end
function button.left()
	return love.keyboard.isDown("a") or love.keyboard.isDown("left")
end

return button

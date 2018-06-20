local button = {}

function button.up()
	local upRaw = love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("space")
	local ret = upRaw and bool.inv("up-down-last")
	bool.set("up-down-last", upRaw)
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
function button.inventory()
	local invRaw = love.keyboard.isDown("e") or love.keyboard.isDown("b") or love.keyboard.isDown("i")
	local ret = invRaw and bool.inv("inventory-down-last")
	bool.set("inventory-down-last", invRaw)
	return ret
end

return button

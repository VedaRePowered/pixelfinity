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

function button.hotbar1()
	local invRaw = love.keyboard.isDown("1") or love.keyboard.isDown("kp1")
	local ret = invRaw and bool.inv("hotbar-1-down-last")
	bool.set("hotbar-1-down-last", invRaw)
	return ret
end

function button.hotbar2()
	local invRaw = love.keyboard.isDown("2") or love.keyboard.isDown("kp2")
	local ret = invRaw and bool.inv("hotbar-2-down-last")
	bool.set("hotbar-2-down-last", invRaw)
	return ret
end

function button.hotbar3()
	local invRaw = love.keyboard.isDown("3") or love.keyboard.isDown("kp3")
	local ret = invRaw and bool.inv("hotbar-3-down-last")
	bool.set("hotbar-3-down-last", invRaw)
	return ret
end

function button.hotbar4()
	local invRaw = love.keyboard.isDown("4") or love.keyboard.isDown("kp4")
	local ret = invRaw and bool.inv("hotbar-4-down-last")
	bool.set("hotbar-4-down-last", invRaw)
	return ret
end

function button.hotbar5()
	local invRaw = love.keyboard.isDown("5") or love.keyboard.isDown("kp5")
	local ret = invRaw and bool.inv("hotbar-5-down-last")
	bool.set("hotbar-5-down-last", invRaw)
	return ret
end

function button.hotbar6()
	local invRaw = love.keyboard.isDown("6") or love.keyboard.isDown("kp6")
	local ret = invRaw and bool.inv("hotbar-6-down-last")
	bool.set("hotbar-6-down-last", invRaw)
	return ret
end

function button.hotbar7()
	local invRaw = love.keyboard.isDown("7") or love.keyboard.isDown("kp7")
	local ret = invRaw and bool.inv("hotbar-7-down-last")
	bool.set("hotbar-7-down-last", invRaw)
	return ret
end

function button.hotbar8()
	local invRaw = love.keyboard.isDown("8") or love.keyboard.isDown("kp8")
	local ret = invRaw and bool.inv("hotbar-8-down-last")
	bool.set("hotbar-8-down-last", invRaw)
	return ret
end

function button.hotbar9()
	local invRaw = love.keyboard.isDown("9") or love.keyboard.isDown("kp9")
	local ret = invRaw and bool.inv("hotbar-9-down-last")
	bool.set("hotbar-9-down-last", invRaw)
	return ret
end

function button.hotbar10()
	local invRaw = love.keyboard.isDown("0") or love.keyboard.isDown("kp0")
	local ret = invRaw and bool.inv("hotbar-0-down-last")
	bool.set("hotbar-0-down-last", invRaw)
	return ret
end

function button.debug()
	local invRaw = love.keyboard.isDown("f3")
	local ret = invRaw and bool.inv("debug-down-last")
	bool.set("debug-down-last", invRaw)
	return ret
end

function button.fullscreen()
	local invRaw = love.keyboard.isDown("f12")
	local ret = invRaw and bool.inv("fullscreen-down-last")
	bool.set("fullscreen-down-last", invRaw)
	return ret
end


function button.breakBlock()
	return love.mouse.isDown(1)
end

function button.use()
	return love.mouse.isDown(2)
end

return button


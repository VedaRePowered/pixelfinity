collision = {}

function collision.limit(w, h, x, y, xv, yv)

	if not ( block.get(worldFunc.get(x+xv, y)).intangable and block.get(worldFunc.get(x+xv, y+h)).intangable ) then
		x = math.ceil(x + xv)
	elseif not ( block.get(worldFunc.get(x+xv+w, y)).intangable and block.get(worldFunc.get(x+xv+w, y+h)).intangable ) then
		x = math.ceil(x + xv) - w - 0.001
	else
		x = x + xv
	end

	onGround = false

	if not ( block.get(worldFunc.get(x, y+yv)).intangable and block.get(worldFunc.get(x+w, y+yv)).intangable ) then
		y = math.ceil(y + yv)
		onGround = true
	elseif not ( block.get(worldFunc.get(x, y+yv+h)).intangable and block.get(worldFunc.get(x+w, y+yv+h)).intangable ) then
		y = math.ceil(y + yv) - h
	else
		y = y + yv
	end

	return x, y, onGround

end

return collision

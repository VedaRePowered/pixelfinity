local player = {}
local players = {}

function player.new(name, x, y, inv)
	if not inv then
		inv = inventory.fill(10, 5)
	end
	players[name] = {x=x, y=y, inv=inv, vx=0, vy=0, onGround=false, crafting={["in"]=inventory.fill(2, 2, false, 100, 500), out=inventory.fill(2, 2, true, 300, 500)}}
end

function player.move(name, delta)
	local p = players[name]
	if p then
		p.vy = p.vy - delta * 30

		if button.up() and p.onGround then
			p.vy = 10
			p.onGround = false
		end

		if button.right() and not button.left() then
			p.vx = p.vx + delta * 30
		elseif button.left() then
			p.vx = p.vx - delta * 30
		else
			p.vx = misc.slowDown(p.vx, 0.5)
		end

		p.vy = misc.clamp(p.vy, -10, 10)
		p.vx = misc.clamp(p.vx, -10, 10)

		local haltX, haltY
		p.x, p.y, p.onGround, haltX, haltY = collision.limit(0.75, 0.999, p.x, p.y, p.vx * delta, p.vy * delta)
		if haltX then
			p.vx = 0
		end
		if haltY then
			p.vy = 0
		end
	else
		misc.warn("player: not a valid player: " .. name)
	end
end

function player.getInventory(name)
	return players[name]["inv"]
end

function player.getCrafting(name)
	return players[name]["crafting"]
end

function player.getPosition(name)
	return players[name]["x"], players[name]["y"], players[name]["vx"], players[name]["vy"]
end

return player

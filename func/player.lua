local player = {}
local players = {}

function player.new(name, x, y, inventory)
	players[name] = {x=x, y=y, inventory=inventory, vx=0, vy=0, onGround=false}
end

function player.move(name, delta)
	local p = players[name]
	if p then
		if button.up() and p.onGround then
			p.vy = 10
			p.onGround = false
		end

		p.vy = p.vy - delta * 30

		if button.right() and not button.left() then
			p.vx = p.vx + delta * 30
		elseif button.left() then
			p.vx = p.vx - delta * 30
		else
			p.vx = misc.slowDown(p.vx, 0.5)
		end

		p.vy = misc.clamp(p.vy, -10, 10)
		p.vx = misc.clamp(p.vx, -10, 10)

		p.x, p.y, p.onGround = collision.limit(0.75, 1, p.x, p.y, p.vx * delta, p.vy * delta)
	else
		misc.warn("player: not a valid player: " .. name)
	end
end

function player.getPosition(name)
	return players[name]["x"], players[name]["y"]
end

return player

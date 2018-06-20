local collision = {}

function finalCheck(w, h, x, y, xv, yv)

	local haltX, haltY = false, false

	if not ( block.get(worldFunc.get(x+xv, y)).intangable and block.get(worldFunc.get(x+xv, y+h)).intangable ) then
		x = math.ceil(x + xv)
		haltX = true
	elseif not ( block.get(worldFunc.get(x+xv+w, y)).intangable and block.get(worldFunc.get(x+xv+w, y+h)).intangable ) then
		x = math.ceil(x + xv) - w - 0.001
		haltX = true
	else
		x = x + xv
	end

	local onGround = false

	if not ( block.get(worldFunc.get(x, y+yv)).intangable and block.get(worldFunc.get(x+w, y+yv)).intangable ) then
		y = math.ceil(y + yv)
		onGround = true
		haltY = true
	elseif not ( block.get(worldFunc.get(x, y+yv+h)).intangable and block.get(worldFunc.get(x+w, y+yv+h)).intangable ) then
		y = math.ceil(y + yv) - h
		haltY = true
	else
		y = y + yv
	end

	return x, y, onGround, haltX, haltY

end

function collision.limit(w, h, x, y, xv, yv)
	if xv == 0 and xy == 0 then
		return x, y, true, true, true
	end

	local angle = math.atan2(yv, xv)
	local oneX, oneY = math.cos(angle), math.sin(angle)

	local done = false
	local curX, curY = x, y
	while not done do
		curX, curY = curX + oneX, curY + oneY

		-- if curX or curY are past x+xv, y+yv, do final check
		if math.abs(curX - x) > math.abs(xv) or math.abs(curY - y) > math.abs(yv) then
			return finalCheck(w, h, x, y, xv, yv)
		end

		-- if not, do middle check
		local hits = {}
		hitCheck(hits, curX, curY)
		hitCheck(hits, curX+w, curY)
		hitCheck(hits, curX, curY+h)
		hitCheck(hits, curX+w, curY+h)

		if #hits then
			local closestHit = 1
			local closestDist = math.huge
			for hitID, hit in ipairs(hits) do
				local hitDist = (x-hit.x)^2 + (y-hit.y)^2
				if hitDist < closestDist then
					closestDist = hitDist
					closestHit = hitID
				end
			end

			local hitX, hitY = hits[closestHit]["x"], hits[closestHit]["y"]

			isAbove(x+w/2, y+h/2, x+xv+w/2, y+yv+h/2, hitX+0.5, hitY+0.5)
			print("dot here i don't know")
			return hitX, hitY, true, true, true

		end

	end

end

function hitCheck(hits, curX, curY)
	if not worldFunc.get(curX, curY).intangable then
		table.insert(hits, {x=math.floor(curX), y=math.floor(curY)})
	end
end

function isAbove(startX, startY, endX, endY, blockX, blockY)
	if startX == endX then
		if startY <= endY then
			return blockX > startX
		else
			return blockX < startX
		end
	end
	local m = (endY-startY) / (endX-startX)
	local b = startY - m*startX

	return blockY < m * blockX + b

end

return collision

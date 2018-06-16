zoom = {}
zoomLevel = 4

function zoom.offset()
	return 0, 0
end

function zoom.xBlocks()
	local width = love.window.getMode()
	return width/16/zoomLevel
end

function zoom.yBlocks()
	local _, height = love.window.getMode()
	return height/16/zoomLevel
end

function zoom.blockSize()
	return 16*zoomLevel
end

function zoom.getLevel()
	return zoomLevel
end

return zoom

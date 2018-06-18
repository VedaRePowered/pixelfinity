zoom = {}
zoomLevel = 8

if zoomLevel == 0 then
	misc.error("zoom: zoomLevel cannot be 0")
end

function zoom.offset()
	local width, height = love.window.getMode()
	return width/2/zoomLevel/16, height/2/zoomLevel/16
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

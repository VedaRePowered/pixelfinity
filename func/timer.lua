timer = {}
timers = {}

function timer.new(name)
	timers[name] = love.timer.getTime()
end

function timer.reset(name)
	timers[name] = love.timer.getTime()
end

function timer.getTime(name)
	if timers[name] then
		return love.timer.getTime() - timers[name]
	else
		return 0
	end
end

return timer

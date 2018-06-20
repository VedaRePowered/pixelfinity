-- a simple file to keep track of bools
local bool = {}
local bools = {}

function bool.new(name, state) -- just an alias
	bool.set(name, state)
end

function bool.del(name)
	bools[name] = nil
end

function bool.set(name, state)
	if state then
		bools[name] = true
	else
		bools[name] = false
	end
end

function bool.get(name)
	return bools[name]
end

function bool.inv(name) -- inv = inverted
	return not bools[name]
end

function bool.doFunction(name, runFunction)
	if bools[name] then
		runFunction()
	end
end

function bool.toggle(name)
	bools[name] = not bools[name]
end

return bool

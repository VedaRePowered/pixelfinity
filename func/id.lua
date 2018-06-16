local id = {}
local ids = {}

function id.get(name)
	return ids[name]
end

function id.new(name, newID)
	ids[name] = newID
end

return id

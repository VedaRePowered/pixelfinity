local status = {}
status.current = "load"

function status.check(currentStatus)
	if status.current == currentStatus then
		return true
	else
		return false
	end
end

function status.change(newStatus)
	status.current = newStatus
end

return status

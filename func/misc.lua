local misc = {}

function misc.sep(str, char)
	local list = {}
        local element = ""
        for i = 1, string.len(str) do
                if string.sub(str, i, i) == char then
                        table.insert(list, element)
                        element = ""
                else
                        element = element .. string.sub(str, i, i)
                end
        end
        table.insert(list, element)
        return list[1], list, table.unpack(list)
end

function misc.randLine(file)
	local fileList = {}
	local f = io.open("assets/" .. file, "r")
	local line = ""
	while line do
		line = f:read("*line")
		fileList[#fileList+1] = line
	end
	return fileList[math.random(1, #fileList)]
end

return misc

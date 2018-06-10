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

return misc

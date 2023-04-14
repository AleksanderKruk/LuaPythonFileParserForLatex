
local myutils = {}

function myutils.printDict(dictionary)
    for key, value in pairs(dictionary) do
        print(key .. " : " .. value)
    end
end


function myutils.printDictOfDicts(dictionary)
    for key, value in pairs(dictionary) do
        print(key)
        myutils.printDict(value)
    end
end


function myutils.loadLines(file_path)
    local file = io.open(file_path)
    local file_lines = {}
    if file then
        for line in file:lines() do
            table.insert(file_lines, line)
        end
        file:close()
    end
    return file_lines
end


function myutils.ifNil(examined_value, new_value)
  if examined_value == nil then
    return new_value
  else
    return examined_value
  end
end


function myutils.ifNilDict(examined_value)
    return myutils.ifNil(examined_value, {})
end



return myutils
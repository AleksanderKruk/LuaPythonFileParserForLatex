
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


function myutils.ifNilTrue(examined_value)
    return myutils.ifNil(examined_value, true)
end


function myutils.ifNilFalse(examined_value)
    return myutils.ifNil(examined_value, false)
end


function myutils.ifNilZero(examined_value)
    return myutils.ifNil(examined_value, 0)
end


function myutils.ifNilEmptyString(examined_value)
    return myutils.ifNil(examined_value, "")
end

function myutils.ifNilDict(examined_value)
    return myutils.ifNil(examined_value, {})
end

function myutils.strip(string)
  return string:match "^%s*(.-)%s*$"
end


function myutils.rstrip(string)
  return string:match "^(.-)%s*$"
end


function myutils.lstrip(string)
  return string:match "^%s*(.-)$"
end


function myutils.bracketify(string, left_bracket, right_bracket)
  return left_bracket .. string .. right_bracket
end


function myutils.addParentheses(string)
  return myutils.bracketify(string, "(", ")")
end


function myutils.addSquareBrackets(string)
  return myutils.bracketify(string, "[", "]")
end


function myutils.addCurlyBrackets(string)
  return myutils.bracketify(string, "{", "}")
end


function myutils.endWith(local_string, ending)
  if not myutils.endsWith(local_string) then
    local_string = local_string .. ending
    -- local current_ending = local_string.sub(local_string, -string.len(ending))
    -- for current_char_index = 1, #ending do
    --   local current_char = current_ending:sub(current_char_index, current_char_index)
    --   for ending_char_index = 1, #ending do
    --     local ending_char = current_ending:sub(ending_char_index, ending_char_index)
    --     if ending_char ~= current_char then
          
    --     end
    --   end
    -- end
  end
  return local_string
end

function myutils.endsWith(local_string, ending)
  local current_ending = string.sub(local_string, -string.len(ending))
  return ending == current_ending
end


function myutils.startsWith(local_string, beginning)
  local current_ending = string.sub(local_string, string.len(beginning))
  return beginning == current_ending
end


function myutils.startWith(local_string, beginning)
  if not myutils.startsWith(local_string) then
    local_string = beginning .. local_string 
  end
  return local_string
end


return myutils
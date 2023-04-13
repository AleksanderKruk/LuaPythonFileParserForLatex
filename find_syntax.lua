
local function printDict(dictionary)
    for key, value in pairs(dictionary) do
        print(key .. " : " .. value)
    end
end


local function printDictOfDicts(dictionary)
    for key, value in pairs(dictionary) do
        print(key)
        printDict(value)
    end
end


local function isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
end


local function isPythonDefLine(line)
    return isPythonFunctionDefLine(line)
end


local function isPythonContinutationLine(line)
    return not isPythonDefLine(line)
end

local function makeFunction(start_line, end_line, function_name, indent_level)
    return {
        start_line = start_line,
        end_line = end_line,
        name = function_name,
        indent_level =  indent_level,
    }
end

local function makeStructureDictionary(functions, classes)
    return {
        functions =  functions,
        classes =  classes,
    }
end


local function makeEmptyStructureDictionary()
    return makeStructureDictionary({}, {})
end

local function scanDefiningLine(line, line_number, structures_dictionary)
    local indent_level, function_name = isPythonFunctionDefLine(line)
    if function_name then
        structures_dictionary.functions[function_name] = makeFunction(line_number, nil, function_name, indent_level)
    end
    return function_name
    -- structures_dictionary.classes.function_name = { indent_level  }
end


local function loadLines(file_path)
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



function ParsePythonFile(file_path)
    local all_lines = loadLines(file_path)
    local structures = makeEmptyStructureDictionary()
    local line_counter = 1
    while line_counter ~= #all_lines + 1 do
        local def_line = all_lines[line_counter]
        local structure_name = scanDefiningLine(def_line, line_counter, structures)
        if structure_name then
            line_counter = line_counter + 1
            while
                line_counter ~= #all_lines + 1
                and
                isPythonContinutationLine(all_lines[line_counter])
            do
                line_counter = line_counter + 1
            end
            line_counter = line_counter - 1
            structures.functions[structure_name].end_line = line_counter
        end
        line_counter = line_counter + 1
    end
    return structures
end


-- printDict(st)

local str = ParsePythonFile("test.py")

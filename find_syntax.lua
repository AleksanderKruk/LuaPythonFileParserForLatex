
local function printDict(dictionary)
    for key, value in pairs(dictionary) do
        print(key .. " : " .. value)
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

local function makeFunction(line_number, function_name, indent_level)
    return {
        line_number =  line_number,
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
    structures_dictionary.functions[function_name] = makeFunction(line_number, function_name, indent_level)

    return function_name
    -- structures_dictionary.classes.function_name = { indent_level  }
end






function ParsePythonFile(file_name)
    local python_file = io.open(file_name)
    local structures = makeEmptyStructureDictionary()
    if python_file then
        local line_counter = 1
        local all_lines = python_file:lines()
        while line_counter ~= #all_lines do
            local def_line = all_lines[line_counter]
            local structure_name = scanDefiningLine(def_line, line_counter, structures)
            if structure_name then
                line_counter = line_counter + 1
                local current_line = all_lines[line_counter]
                while line_counter ~= #all_lines and isPythonContinutationLine(current_line) do
                    
                    line_counter = line_counter + 1
                end
            end
            line_counter = line_counter + 1
        end
        python_file:close()
        -- print(structures)
    end
end


-- ParsePythonFile("test.py")
-- local testowa = { 1, 2, 3, 4}
-- testowa.a = "a"
-- testowa.b = nil
-- testowa["c"] = nil

-- print(testowa[1])



local function isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
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
    return makeStructureDictionary(nil, nil)
end

local function scanDefiningLine(line, line_number, structures_dictionary)
    local indent_level, function_name = isPythonFunctionDefLine(line)
    print(function_name)
    if function_name then
        local tmp = makeFunction(line_number, function_name, indent_level)
        print(tmp)
        -- structures_dictionary.functions[function_name] = makeFunction(line_number, function_name, indent_level)
        structures_dictionary.functions[function_name] = makeFunction(line_number, function_name, indent_level)
    else

    end

    -- structures_dictionary.classes.function_name = { indent_level  }
end






function ParsePythonFile(file_name)
    local python_file = io.open(file_name)
    local found_functions = {}
    local found_classes = {}
    local structures = makeEmptyStructureDictionary()
    local line_counter = 1
    if python_file then
        for line in python_file:lines() do
            scanDefiningLine(line, line_counter, structures)
            line_counter = line_counter + 1
        end
        python_file:close()
        print(structures)
    end
end


-- ParsePythonFile("test.py")
-- local testowa = {}
-- testowa.a = "a"
-- testowa.b = nil
-- testowa["c"] = nil

-- print(
--     testowa.a
-- )


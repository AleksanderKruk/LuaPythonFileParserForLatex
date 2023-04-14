local myutils = require("myutils")
local PFP = require("PythonFileParser")

local function isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
end


local function isPythonClassDefLine(line)
    local indent_level, class_name = string.match(line, "(%s*)class%s*([%w_]+)%(?.*")
    return indent_level, class_name
end


local function isPythonDefLine(line)
    return isPythonFunctionDefLine(line) or isPythonClassDefLine(line)
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


local function scanDefiningLine(line, line_number, structures_dictionary)
    local indent_level, function_name = isPythonFunctionDefLine(line)
    if function_name then
        structures_dictionary.functions[function_name] = makeFunction(line_number, nil, function_name, indent_level)
    end
    return function_name
end



local function searchForEndOfStructure(all_lines, line_counter, structures, structure_name)
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
    return line_counter
end


local function searchForStructure(all_lines, line_counter, structures)
    local def_line = all_lines[line_counter]
    local structure_name = scanDefiningLine(def_line, line_counter, structures)
    if structure_name then
        line_counter = searchForEndOfStructure(all_lines, line_counter, structures, structure_name)
    end
    line_counter = line_counter + 1
    return line_counter
end

function ParsePythonFile(file_path)
    local all_lines = myutils.loadLines(file_path)
    local structures = PFP.PythonFileParser:new()
    local line_counter = 1
    while line_counter ~= #all_lines + 1 do
        line_counter = searchForStructure(all_lines, line_counter, structures)
    end
    return structures
end



local str = ParsePythonFile("test.py")

myutils.printDictOfDicts(str.functions)


local function isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
end


local function scanDefiningLine(line, structures_dictionary)
    local indent_level, function_name = isPythonFunctionDefLine(line)
    structures_dictionary["functions"][function_name] = { indent_level } 
    struc
    print("   ")
end


function ParsePythonFile(file_name)
    local python_file = io.open(file_name)
    local found_functions = {}
    local found_classes = {}
    local structures = {}
    local line_counter = 1
    if python_file then
        for line in python_file:lines() do
            scanDefiningLine(line)
            -- print(first_indent)
            -- print(function_name)
            if first_indent or function_name then
                print(first_indent, function_name)
            else
                
            end
            line_counter = line_counter + 1
        end
        python_file:close()
    end
end


ParsePythonFile("test.py")




local function isPythonFunctionDefLine(line)
    local first_indent, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return first_indent, function_name
end


function ParsePythonFile(file_name)
    local python_file = io.open(file_name)
    local found_functions = {}
    local found_classes = {}
    local line_counter = 1
    if python_file then
        for line in python_file:lines() do
            local first_indent, function_name = isPythonFunctionDefLine(line)
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



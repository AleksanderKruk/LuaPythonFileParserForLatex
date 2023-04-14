
local pythonfilefunctions = {}


function pythonfilefunctions.isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
end


function pythonfilefunctions.isPythonClassDefLine(line)
    local indent_level, class_name = string.match(line, "(%s*)class%s*([%w_]+)%(?.*")
    return indent_level, class_name
end


function pythonfilefunctions.isPythonDefLine(line)
    return pythonfilefunctions.isPythonFunctionDefLine(line) or pythonfilefunctions.isPythonClassDefLine(line)
end


function pythonfilefunctions.sisPythonContinutationLine(line)
    return not pythonfilefunctions.isPythonDefLine(line)
end

return pythonfilefunctions
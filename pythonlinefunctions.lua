
local pythonlinefunctions = {}


function pythonlinefunctions.isPythonFunctionDefLine(line)
    local indent_level, function_name = string.match(line, "(%s*)def%s*([%w_]+)%(.*")
    return indent_level, function_name
end


function pythonlinefunctions.isPythonClassDefLine(line)
    local indent_level, class_name = string.match(line, "(%s*)class%s*([%w_]+)%(?.*")
    return indent_level, class_name
end


function pythonlinefunctions.isPythonDefLine(line)
    return pythonlinefunctions.isPythonFunctionDefLine(line) or pythonlinefunctions.isPythonClassDefLine(line)
end


function pythonlinefunctions.isPythonContinutationLine(line)
    return not pythonlinefunctions.isPythonDefLine(line)
end

return pythonlinefunctions
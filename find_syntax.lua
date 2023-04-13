
function ParsePythonFile(file_name)
    local python_file = io.open(file_name)
    local found_functions = {}
    local found_classes = {}
    if python_file then
        for line in python_file:lines() do
            local groups = string.match( line, "%s*def.*" )
            if groups then
                print(groups)
            end

        end
        python_file:close()
    end
end


ParsePythonFile("test.py")




function Parse_python_file(file_name)
    local python_file = io.open(file_name)

    if python_file then
        for python_file in python_file:lines() do
            print(python_file)

        end
        python_file:close()
    end

end


Parse_python_file("test.py")



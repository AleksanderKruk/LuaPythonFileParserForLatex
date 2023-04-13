



local python_file = io.open("test.py")

if python_file then
    for python_file in python_file:lines() do
        print(python_file)

    end
    python_file:close()
end





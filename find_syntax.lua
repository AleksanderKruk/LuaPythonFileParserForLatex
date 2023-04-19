local myutils = require("myutils")
local PythonFileParser = require("PythonFileParser")

local parser = PythonFileParser:new()
local found_structures = parser:parseFile("test.py")

-- local text = parser:getFunctionText("no_argument")
local text2 = parser:getFunctionText("__main__")


print(text2)
-- myutils.printDictOfDicts(found_structures.functions)

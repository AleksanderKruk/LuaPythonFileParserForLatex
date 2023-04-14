local myutils = require("myutils")
local PythonFileParser = require("PythonFileParser")

local parser = PythonFileParser:new()
local found_structures = parser:parseFile("test.py")

local text = parser:getFunctionText("no_argument")
local text2 = parser:getFunctionText("multi_line")


print(text)
print(text2)
-- myutils.printDictOfDicts(found_structures.functions)

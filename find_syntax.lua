local myutils = require("myutils")
local PythonFileParser = require("PythonFileParser")

local parser = PythonFileParser:new()
local found_structures = parser:parseFile("server.py")

-- local text = parser:getFunctionText("no_argument")
local text = parser:getFunctionText("__main__")

tex = {}
tex.print = print
-- print(myutils.printListing(parser, "__main__"))
print(myutils.printListingWithCaption(parser, "__main__", "GARNUCH"))
-- print(text)
-- print(text)
-- myutils.printDictOfDicts(found_structures.functions)

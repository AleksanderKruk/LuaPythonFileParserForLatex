local myutils = require("myutils")
local PFP = require("PythonFileParser")
local PyFunStr = require("PythonFunctionStructure")
local PyLinefs = require("pythonlinefunctions")

local parser = PFP:new()
local str = parser:parseFile("test.py")

myutils.printDictOfDicts(str.functions)

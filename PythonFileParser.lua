local myutils = require "myutils"


local PythonFileParser = {
  functions = {},
  classes = {},
}
PythonFileParser.__index = PythonFileParser


function PythonFileParser:new(functions, classes)

  local obj = {}
  setmetatable(obj, self)
  obj.functions = myutils.ifNilDict(functions)
  obj.classes = myutils.ifNilDict(classes)

  return obj
end


function PythonFileParser:newEmpty()
    return PythonFileParser:new({}, {})
end



return PythonFileParser
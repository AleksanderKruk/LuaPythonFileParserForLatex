
local myutils = require "myutils"

local FunctionStructure = {
        start_line = 0,
        end_line = 0,
        name = "",
        indent_level =  "",
    }


FunctionStructure.__index = FunctionStructure


function FunctionStructure:new(
    start_line, end_line, name, indent_level
)
  local obj = {}
  setmetatable(obj, self)
  obj.start_line = myutils.ifNilZero(start_line)
  obj.end_line = myutils.ifNilZero(end_line)
  obj.name = myutils.ifNilEmptyString(name)
  obj.indent_level = myutils.ifNilEmptyString(indent_level)
  return obj
end


return FunctionStructure
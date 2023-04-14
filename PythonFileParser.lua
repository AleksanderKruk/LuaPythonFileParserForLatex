local myutils = require "myutils"


local PythonFileParser = {
  functions = {},
  classes = {},
}
PythonFileParser.__index = PythonFileParser


function PythonFileParser:new(functions, classes)
  functions = myutils.ifNilDict(functions)
  classes = myutils.ifNil(classes)

  local obj = {}
  setmetatable(obj, self)
  obj.functions = functions
  obj.classes = classes
  return obj
end


function PythonFileParser:newEmpty()
    return PythonFileParser:new({}, {})
end




-- function PythonLanguageStructures:new(value)
--   local obj = {}
--   setmetatable(obj, self)
--   obj.value = value
--   return obj
-- end


-- function PythonLanguageStructures:setValue(new_value)
--   self.value = new_value
-- end


-- function PythonLanguageStructures:getValue()
--   return self.value
-- end

return PythonFileParser
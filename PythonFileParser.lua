local myutils = require "myutils"
local PyFunStr = require("PythonFunctionStructure")
local PyLinefs = require("pythonlinefunctions")


local PythonFileParser = {
  python_structures = {
    classes = {},
    functions = {},
  },
  loaded_files = {},
  last_scanned_line = "",
  last_scanned_lineno = 1,
}
PythonFileParser.__index = PythonFileParser


function PythonFileParser:new()
  local obj = {}
  setmetatable(obj, self)
  obj.python_structures  = {
    functions = {},
    classes = {},
  }
  obj.loaded_lines = {}
  obj.last_scanned_lineno = 1
  return obj
end


function PythonFileParser:getLastScannedLine(functions, classes)
  return self.loaded_lines[self.last_scanned_lineno]
end


function PythonFileParser:scanDefiningLine()
  local indent_level, function_name = PyLinefs.isPythonFunctionDefLine(self:getLastScannedLine())
  if function_name then
    self.python_structures.functions[function_name] = PyFunStr:new(
      self.last_scanned_lineno, nil, function_name, indent_level)
  end
  return function_name
end


function PythonFileParser:searchForEndOfStructure(structure_name)
  self.last_scanned_lineno = self.last_scanned_lineno + 1
  while
    self.last_scanned_lineno ~= #self.loaded_lines + 1 
    and
    PyLinefs.isPythonContinutationLine(self.loaded_lines[self.last_scanned_lineno])
  do
    self.last_scanned_lineno = self.last_scanned_lineno + 1
  end
  self.last_scanned_lineno = self.last_scanned_lineno - 1
  self.python_structures.functions[structure_name].end_line = self.last_scanned_lineno
end


function PythonFileParser:searchForStructure()
  local structure_name = self:scanDefiningLine()
  if structure_name then
    self:searchForEndOfStructure(structure_name)
  end
  self.last_scanned_lineno = self.last_scanned_lineno + 1
  return self.last_scanned_lineno
end


function PythonFileParser:parseFile(file_path)
    self.loaded_lines = myutils.loadLines(file_path)
    self.last_scanned_lineno = 1
    while self.last_scanned_lineno ~= #self.loaded_lines + 1 do
      self:searchForStructure()
    end
    return self.python_structures
end


return PythonFileParser
local myutils = require "myutils"
local PyFunStr = require("PythonFunctionStructure")
local PyLineFs = require("pythonlinefunctions")
local latexintegrationfunctions = require("latexintegrationfunctions")


local PythonFileParser = {
  python_structures = {
    classes = {},
    functions = {},
  },
  loaded_lines = {},
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


function PythonFileParser:getLastScannedLine()
  return self.loaded_lines[self.last_scanned_lineno]
end


function PythonFileParser:scanDefiningLine()
  local last_scanned_line = self:getLastScannedLine()
  local indent_level, function_name = PyLineFs.isPythonFunctionDefLine(last_scanned_line)
  if function_name then
    self.python_structures.functions[function_name] = PyFunStr:new(
      self.last_scanned_lineno, nil, function_name, indent_level)
    return function_name
  end
  local indent_level, class_name = PyLineFs.isPythonClassDefLine(last_scanned_line)
  if class_name then
    -- TODO Create new class for class structure
    self.python_structures.classes[class_name] = PyFunStr:new(
      self.last_scanned_lineno, nil, class_name, indent_level)
    return class_name
  end
  local indent_level, main = PyLineFs.isPythonMain(last_scanned_line)
  if main then
    self.python_structures.functions[main] = PyFunStr:new(
      self.last_scanned_lineno, nil, main, indent_level)
    return main
  end
end


function PythonFileParser:searchForEndOfStructure(structure_name)
  repeat
    self.last_scanned_lineno = self.last_scanned_lineno + 1
  until 
    self.last_scanned_lineno ~= #self.loaded_lines + 1
    and
    PyLineFs.isPythonContinutationLine(self:getLastScannedLine())
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


function PythonFileParser:trimFunctionText(function_text)
  local processed_function_text = myutils.rstrip(function_text)
  return processed_function_text
end


function PythonFileParser:trimClassText(function_text)
  local processed_function_text = myutils.rstrip(function_text)
  return processed_function_text
end



function PythonFileParser:getFunctionText(function_name)
  local loaded_function = self.python_structures.functions[function_name]
  if loaded_function then
    local function_text = self:getTextFragment(loaded_function)
    function_text = self:trimFunctionText(function_text)
    return function_text
  end
end


function PythonFileParser:getTextFragmentLines(text_object)
  local start_line = text_object.start_line
  local end_line = text_object.end_line
  return {table.unpack(self.loaded_lines, start_line, end_line)}
end


function PythonFileParser:getTextFragment(text_object)
  local lines = self:getTextFragmentLines(text_object)
  return table.concat(lines, "\n")
end


function PythonFileParser:getClassText(class_name)
  local loaded_class = self.python_structures.classes[class_name]
  if loaded_class then
    local function_text = self:getTextFragment(loaded_class)
    function_text = self:trimClassText(function_text)
    return function_text
  end
end


function PythonFileParser:getStructure(structure_name)
  local loaded_function = self.python_structures.functions[structure_name]
  local loaded_class = self.python_structures.classes[structure_name]
  if loaded_function then
    return loaded_function
  elseif loaded_class then
    return loaded_class
  end
end


function PythonFileParser:getStructureText(structure_name)
  local found_class = self:getClassText(structure_name)
  local found_function = self:getFunctionText(structure_name)
  if found_class then
    return found_class
  elseif found_function then
    return found_function
  end
end


function PythonFileParser:makeListing(structure_name)
  local structure = self:getStructure(structure_name)
  if structure then
    local structure_text = self:getStructureText(structure_name)
    local range = "linerange=" .. myutils.addCurlyBrackets(structure.start_line .. "-" .. structure.end_line)
    local latex_text = latexintegrationfunctions.toEnvironment(structure_text, "lstlisting", range)
    return latex_text
  end
end



return PythonFileParser



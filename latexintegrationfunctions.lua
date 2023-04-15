local myutils = require "myutils"
local latexintegrationfunctions = {}

function latexintegrationfunctions.toEnvironment(text, environment_name, optional_args)
  local braced_environment_name = myutils.addCurlyBrackets(environment_name)
  local latex_text = "\\begin" .. braced_environment_name
  if optional_args then
    latex_text = latex_text .. myutils.addSquareBrackets(optional_args)
  end
  latex_text = latex_text .. "\n" .. text .. "\n\\end" .. braced_environment_name
  -- if optional_args then
  --   latex_text = latex_text .. "[" .. optional_args .. "]"
  -- end
  return latex_text
end





return latexintegrationfunctions
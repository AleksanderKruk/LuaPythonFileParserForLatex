local myutils = require "myutils"
local latexintegrationfunctions = {}

function latexintegrationfunctions.toEnvironment(text, environment_name, optional_args)
  local latex_text = "\\begin{" .. environment_name .. "}"
  if optional_args then
    latex_text = latex_text .. "[" .. optional_args .. "]"
  end
  latex_text = latex_text .. "\n" .. text .. "\n\\end{" .. environment_name .. "}"
  -- if optional_args then
  --   latex_text = latex_text .. "[" .. optional_args .. "]"
  -- end
  return latex_text
end





return latexintegrationfunctions
-- set syntax value based on how big the file is
local syntax_value = "on"
if vim.fn.line('$') > 500 then
  syntax_value = "off"
end

local options = {
  -- number of visual spaces per tab
  tabstop = 2,

  -- number of spaces in tab when editing
  softtabstop = 2,

  -- number of spaces to use for autoindent
  shiftwidth = 2,

  -- exnapd tab to spaces so that tabs are spaces
  expandtab = true,

  -- syntax enable/disable
  syntax = syntax_value,
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

local options = {
  -- number of visual spaces per tab
  tabstop = 2,

  -- number of spaces in tab when editing
  softtabstop = 2,

  -- number of spaces to use for autoindent
  shiftwidth = 2,

  -- exnapd tab to spaces so that tabs are spaces
  expandtab = true,
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

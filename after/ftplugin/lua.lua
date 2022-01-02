local buffer_options = {
  -- number of visual spaces per TAB
  tabstop = 2,

  -- number of spaces in tab when editing
  softtabstop = 2,

  -- number of spaces to use for autoindent
  shiftwidth = 2,

  -- expand tab to spaces so that tabs are spaces
  expandtab = true,
}

for k, v in pairs(buffer_options) do
  vim.bo[k] = v
end


local options = {
  formatoptions = vim.opt.formatoptions - 'r' - 'o',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

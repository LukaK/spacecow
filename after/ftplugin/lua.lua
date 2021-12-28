local options = {
  -- TODO: This option is not buffer specific
  -- disable inserting comment leader after hitting o or O or <Enter>
  -- formatoptions = vim.opt.formatoptions - "o" - "r",

  -- number of visual spaces per TAB
  tabstop = 2,

  -- number of spaces in tab when editing
  softtabstop = 2,

  -- number of spaces to use for autoindent
  shiftwidth = 2,

  -- expand tab to spaces so that tabs are spaces
  expandtab = true,q
}

for k, v in pairs(options) do
    vim.bo[k] = v
end

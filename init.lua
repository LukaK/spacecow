require "user.globals"
require "user.plugins"
require "user.colorscheme"
require "user.mappings"
require "user.options"

-- source vimscript files that are not yet supported
local nvim_path = vim.fn.stdpath('config')
local vimscript_files = {"autocommands.vim"}

for _, vimscript_file in pairs(vimscript_files) do
  vim.cmd("source " .. nvim_path .. "/vimscript/" .. vimscript_file)
end

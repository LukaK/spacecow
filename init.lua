-- source lua config module
require "user"

-- source vimscript configuration
local nvim_path = vim.fn.stdpath('config')
local vimscript_files = {"autocommands.vim"}

for _, vimscript_file in ipairs(vimscript_files) do
  vim.cmd("source " .. nvim_path .. "/vimscript/" .. vimscript_file)
end

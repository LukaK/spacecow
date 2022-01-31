local utils = require "user.utils"
local status_ok, configs = utils.vprequire("nvim-treesitter.configs", "treesitter")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "maintained",
  ignore_install = {"ocamllex"}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  -- colors = {}, -- table of hex strings
  -- termcolors = {} -- table of colour name strings
  },
  matchup = { enable = true }
})

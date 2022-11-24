local telescope = require "telescope"
telescope.setup {
  defaults = {file_ignore_patterns = {"^tests/coverage/"}},
  extensions = {
    media_files = {
      -- filetypes whitelist
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
}

-- load extension
telescope.load_extension("media_files")
telescope.load_extension("fzf")

-- key bindings
local opts = { noremap = true, silent = true }
local wk = require "which-key"
wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope git_files<cr>", "Find git files" },
    F = { "<cmd>Telescope find_files hidden=true<cr>", "Find hidden files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep files" },
    G = {"<cmd> lua require('telescope.builtin').live_grep({additional_args=function() return {'--hidden'} end})<cr>", "Grep hidden files"},
    m = {"<cmd> luarequire('telescope').extensions.media_files.media_files()<cr>", "Grep media files"}
  },
}, opts)

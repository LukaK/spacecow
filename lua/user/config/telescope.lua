local telescope = require "telescope"
telescope.setup {
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
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "Ff", ":Telescope git_files<CR>", opts)
keymap("n", "FF", ":Telescope find_files hidden=true<CR>", opts)
keymap("n", "Fg", ":Telescope live_grep<CR>", opts)
keymap("n", "FG", ":lua require('telescope.builtin').live_grep({additional_args=function() return {'--hidden'} end})<cr>", opts)
keymap("n", "Fm", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opts)

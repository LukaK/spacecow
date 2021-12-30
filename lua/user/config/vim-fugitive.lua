local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- -- vim-fugitive mappings
keymap("n", "<leader>G", ":Git<CR>", opts)

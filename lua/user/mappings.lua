-- mapping shorthands
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- telescope keybindings
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

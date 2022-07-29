-- key bindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>c", ":TComment<CR>", opts)
keymap("v", "<leader>c", ":TCommentMaybeInline<CR>", opts)

local wk = require "which-key"
wk.register({["<leader>c"] = {"Comment a line"}}, {mode = "n"})
wk.register({["<leader>c"] = {"Comment visual block"}}, {mode = "v"})

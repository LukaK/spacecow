-- key bindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>c", ":TComment<CR>", opts)
keymap("v", "<leader>c", ":TCommentMaybeInline<CR>", opts)

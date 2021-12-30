local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- t-comment mappings
keymap("n", "<leader>c", ":TComment<CR>", opts)
keymap("v", "<leader>c", ":TCommentMaybeInline<CR>", opts)

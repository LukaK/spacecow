local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- vista mappings
keymap("n", "<leader>f", ":Vista!!<CR>", opts)

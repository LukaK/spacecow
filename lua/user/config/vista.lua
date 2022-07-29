-- key bindings
local opts = { noremap = true, silent = true }
local wk = require "which-key"
wk.register({["<leader>F"] = {"<cmd>Vista!!<cr>", "Open lsp tag window"}}, opts)

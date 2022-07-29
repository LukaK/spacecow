-- key bindings
local wk = require "which-key"
local opts = { noremap = true, silent = true }
wk.register({["<leader>G"] = {"<cmd>Git<cr>", "Open git management"}}, opts)

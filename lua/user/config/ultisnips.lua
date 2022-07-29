-- key bindings
-- TODO: Snippets do not work
vim.g.UltiSnipsEnableSnipMate = 0
vim.g.UltiSnipsExpandTrigger = '<leader>e'
vim.g.UltiSnipsJumpForwardTrigger = '<leader>a'
vim.g.UltiSnipsJumpBackwardTrigger = '<leader>b'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}

local wk = require "which-key"
wk.register({["<leader>e"] = {"Expand a snippet"}}, {mode = "i"})

vim.g.copilot_filetypes = { ["*"] = false, python = true }

vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<leader>E', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
-- vim.keymap.set('i', '<C-t>', '<Plug>(copilot-next)')

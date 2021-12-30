local status_ok, hlslens = pcall(require, "hlslens")
if not status_ok then
  return
end

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

hlslens.setup({
    calm_down = true,
    nearest_only = true,
})

keymap("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
keymap("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
keymap("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
keymap("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { silent = true })

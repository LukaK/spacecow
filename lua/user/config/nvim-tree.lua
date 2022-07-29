require('nvim-tree').setup {
  diagnostics = {
    enable = false,
  },
  view = {
    number = true,
    relativenumber = true,
  }
}

vim.g["nvim_tree_window_picker_exclude"] = {
  filetype = {"notify", "packer", "qf", "vista"},
  buftype = {"terminal"}
}

-- key bindings
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

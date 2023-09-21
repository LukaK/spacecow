require('nvim-tree').setup {
  diagnostics = {
    enable = false,
  },
  view = {
    number = true,
    relativenumber = true,
    width = {
      min = 40,
      max = 40
    }
  }
}

vim.g["nvim_tree_window_picker_exclude"] = {
  filetype = {"notify", "packer", "qf", "vista"},
  buftype = {"terminal"}
}

-- key bindings
local opts = { noremap = true, silent = true }
local wk = require "which-key"
wk.register({["<leader>f"] = {"<cmd>NvimTreeToggle<cr>", "Open file browser"}}, opts)

local utils = require "user.utils"
local status_ok, nvim_tree = utils.vprequire("nvim-tree", "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
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

keymap("n", "<leader>F", ":NvimTreeToggle<CR>", opts)

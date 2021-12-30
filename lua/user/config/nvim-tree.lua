local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  auto_close = true,
  diagnostics = {
    enable = true,
  },
  view = {
    number = true,
    relativenumber = true,
  }
}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- nvim-tree mappings
keymap("n", "<leader>F", ":NvimTreeToggle<CR>", opts)

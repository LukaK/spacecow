local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  auto_close = true,
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

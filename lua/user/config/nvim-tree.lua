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

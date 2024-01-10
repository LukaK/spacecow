local options = {
  expandtab = false,
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

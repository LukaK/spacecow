local options = {
  wrap = false,
  sidescroll = 5,
  sidescrolloff = 2,
  colorcolumn = "100",
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

local window_options = {
  -- dont wrap text
  wrap = false,

}

for k, v in pairs(window_options) do
  vim.wo[k] = v
end

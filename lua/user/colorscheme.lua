local colorscheme = "everforest"

-- everforrest colorscheme configuration
if colorscheme == "everforest" then
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

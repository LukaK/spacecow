local colorscheme = "nord"

-- everforrest colorscheme configuration
if colorscheme == "everforest" then
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1
end

if colorscheme == "nord" then
  require('lualine').setup {
    options = {
      -- ... your lualine config
      theme = 'nord'
      -- ... your lualine config
    }
  }
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

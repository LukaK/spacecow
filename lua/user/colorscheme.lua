-- define colorscheme
local colorscheme = "nord"

-- everforrest colorscheme configuration
if colorscheme == "everforest" then
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1
end

-- nord colorscheme configuration
if colorscheme == "nord" then
  -- TODO: This should be moved to lualine config
  require('lualine').setup {
    options = {
      -- ... your lualine config
      theme = 'nord'
      -- ... your lualine config
    }
  }
  -- Example config in lua
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  vim.g.nord_disable_background = false
  vim.g.nord_italic = false

  -- Load the colorscheme
  require('nord').set()
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  return
end

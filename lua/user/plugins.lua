local fn = vim.fn

-- automatically install packer plugin
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

  print("Installing packer, please restart neovim instance...")
  vim.cmd [[packadd packer.nvim]]
end

-- TODO: Rewrite when support for autocommands come
-- automatically sync packer packages when saving plugins.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- safely load packer module
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- configure packer to use floating window
packer.init {
  display = {
    open_fn = function ()
      return require('packer.util').float { border = "rounded"}
    end,
  },
}

return packer.startup(function(use)

  -- package manager itself
  use "wbthomason/packer.nvim"

  -- useful lua functions for plugins
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- automatically set up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

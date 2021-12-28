local fn = vim.fn

-- automatically install packer plugin
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

  print("Installing packer, please restart neovim instance...")
  vim.cmd [[packadd packer.nvim]]
end

-- TODO: Add explicit check where the file is located .config/nvim
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

  -- it is recommened to put impatient.nvim before any other plugins
  use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

  -- package manager itself
  use "wbthomason/packer.nvim"

  -- useful lua functions for plugins
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- completions plugins
  use {"onsails/lspkind-nvim", event = "BufEnter"}
  use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('user.config.nvim-cmp')]]}
  use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
  use {"hrsh7th/cmp-path", after = "nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
  use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
  -- use {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"}

  -- snippets
  -- use "L3MON4D3/LuaSnip"
  -- use "rafamadriz/friendly-snippets"
  use "SirVer/ultisnips"
  use({ "honza/vim-snippets", after = 'ultisnips'})

  -- lsp
  use "williamboman/nvim-lsp-installer"
  use {"neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('user.config.lsp')]]}

  -- colorschemes
  use "sainnhe/everforest"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('user.config.treesitter')]] }
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter"}

  -- directory navigation
  use {'kyazdani42/nvim-tree.lua', config = [[require('user.config.nvim-tree')]] }

  -- fuzzy search
  use {'nvim-telescope/telescope.nvim', after = "plenary.nvim", config = [[require('user.config.telescope')]]}
  use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}
  -- TODO: make media files work with telescope
  -- use 'nvim-telescope/telescope-media-files.nvim'

  -- TODO: Find lua replacement for t comment
  -- code commenting
  use "vim-scripts/tComment"

  -- buffers
  -- TODO: Add buffer mappings
  use({ "akinsho/bufferline.nvim", event = "VimEnter", config = [[require('user.config.bufferline')]] })

  -- version control: git
  use "mhinz/vim-signify"
  use "tpope/vim-fugitive"
  use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })
  use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

  -- automatically set up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

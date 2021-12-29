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

-- TODO: move mappings to pluggins and make them buffer related
return packer.startup(function(use)

  -- it is recommened to put impatient.nvim before any other plugins
  use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

  -- package manager itself
  use{"wbthomason/packer.nvim", config = [[require('user.config.packer')]]}

  -- useful lua functions for plugins
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-web-devicons"

  -- completions plugins
  use {"onsails/lspkind-nvim", event = "BufEnter"}
  use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('user.config.nvim-cmp')]]}
  use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
  use {"hrsh7th/cmp-path", after = "nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
  use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
  -- use {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"}

  -- TODO: Change ultisnips for lua snippets
  -- snippets
  -- use "L3MON4D3/LuaSnip"
  -- use "rafamadriz/friendly-snippets"
  use "SirVer/ultisnips"
  use({ "honza/vim-snippets", after = 'ultisnips'})

  -- lsp
  -- TODO: Go over documentation and update lsp configuration with new functionality
  -- TODO: Go keymappings and set them up
  -- TODO: Personalize lsp utils module with your stuff
  use {"williamboman/nvim-lsp-installer", config = [[require('user.config.lsp_installer')]]}
  use {"neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('user.config.lsp')]]}

  -- json schemas for language server
  use "b0o/schemastore.nvim"

  -- colorscheme and sintax highlighting
  use "sainnhe/everforest"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('user.config.treesitter')]] }
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter"}

  -- directory management and navigation
  use {'kyazdani42/nvim-tree.lua', cmd = {"NvimTreeToggle"}, config = [[require('user.config.nvim-tree')]] }

  -- fuzzy search
  use "nvim-telescope/telescope-media-files.nvim"
  use {'nvim-telescope/telescope.nvim', after = {"plenary.nvim"}, config = [[require('user.config.telescope')]]}
  use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}

  -- code commenting
  use "vim-scripts/tComment"

  -- buffers management
  use {"akinsho/bufferline.nvim", config = [[require('user.config.bufferline')]], after = "nvim-web-devicons"}

  -- version control: git
  use "mhinz/vim-signify"
  use "tpope/vim-fugitive"
  use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })
  -- when integration with fugitive comes
  -- use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

  -- Python plugins
  use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })
  use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

  -- TODO: See if it is necessary
  -- interactive shell for testing programs
  -- use({ "hkupty/iron.nvim", ft = { "python" }, config = [[require('config.iron')]]})

  -- TODO: Set plugin up
  -- Show match number and index for searching
  use {
    'kevinhwang91/nvim-hlslens',
    branch = 'main',
    keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
    config = [[require('user.config.hlslens')]]
  }

  -- TODO: See if this is needed
  -- -- Stay after pressing * and search selected text
  -- use({"haya14busa/vim-asterisk", event = 'VimEnter'})

  -- TODO: Configure
  -- statusline
  use {'nvim-lualine/lualine.nvim', config = [[require('user.config.statusline')]]}

  -- indent line
  use {"lukas-reineke/indent-blankline.nvim", config = [[require('user.config.indent-blankline')]]}

  -- Highlight URLs inside vim
  use "itchyny/vim-highlighturl"

  -- navigate tags and lsp symbols
  use {"liuchengxu/vista.vim", cmd = "Vista"}

  -- TODO: Add nvim-autopairs

  -- TODO: see if you neet this
  -- use "svermeulen/vim-yoink"

    -- Repeat vim motions
    use "tpope/vim-repeat"

  -- notification plugin
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.defer_fn(function() require('user.config.nvim-notify') end, 2000)
      end
    })

  -- TODO: Add mapping for formatting and setup formatters for python, lua and so on
  -- Auto format tools
  use { "sbdchd/neoformat", cmd = { "Neoformat" } }

  -- -- Another markdown plugin
  use({ "plasticboy/vim-markdown", ft = { "markdown" } })
  --
  -- -- Faster footnote generation
  use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })
  --
  -- -- Vim tabular plugin for manipulate tabular, required by markdown plugins
  use({ "godlygeek/tabular", cmd = { "Tabularize" } })

  -- -- markdown previewer
  -- use({
  --   "iamcco/markdown-preview.nvim",
  --   run = function()
  --     fn["mkdp#util#install"]()
  --   end,
  --   ft = { "markdown" },
  -- })

  -- Markdown JSON header highlight plugin
  use({ "elzr/vim-json", ft = { "json", "markdown" } })

  -- Additional powerful text object for vim, this plugin should be studied
  -- carefully to use its full power
  use "wellle/targets.vim"

  -- Add indent object for vim (useful for languages like Python)
  use "michaeljsmith/vim-indent-object"

  -- Modern matchit implementation
  use "andymass/vim-matchup"

  -- Smoothie motions
  use {
    "karb94/neoscroll.nvim",
    config = function()
      vim.defer_fn(function() require('user.config.neoscroll') end, 2000)
    end
  }

  -- vim sintax for toml
  use { "cespare/vim-toml", ft = { "toml" }, branch = "main" }

  -- The missing auto-completion for cmdline!
  use {"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]}

  --  TODO: Works but see why it is not working for F (telescope) mappings
  -- showing keybindings
  use {"folke/which-key.nvim",
    config = function()
      vim.defer_fn(function() require('user.config.which-key') end, 2000)
    end
  }

  -- show and trim trailing whitespaces
  use 'jdhao/whitespace.nvim'

  -- TODO: Learn how to use quickfix windows in your workflow and then find solution
  -- better quickfix windows
  -- use({ "kevinhwang91/nvim-bqf", event = "FileType qf", config = [[require('user.config.bqf')]] })

  -- automatically set up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

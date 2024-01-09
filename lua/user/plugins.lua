local fn = vim.fn

-- automatically install packer plugin
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

  print("Installing packer, please restart neovim instance...")
  vim.cmd [[packadd packer.nvim]]
end

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

return packer.startup(function(use)

    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = function() require('impatient') end}

    -- package manager itself
    use{"wbthomason/packer.nvim", config = function() require('user.config.packer') end}

    -- useful lua functions for plugins
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- notification plugin
    use {
      "rcarriga/nvim-notify",
      config = function()
        vim.defer_fn(function() require('user.config.nvim-notify') end, 2000)
      end
    }

    -- showing keybindings
    -- TODO: Filter key mappings that are not relevant
    use {"folke/which-key.nvim", config = function() require('user.config.which-key') end}

    -- completions plugins
    use {"onsails/lspkind-nvim"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = "nvim-cmp" }

    use {
      "hrsh7th/nvim-cmp",
      after = "lspkind-nvim",
      config = function()
        vim.defer_fn(function() require('user.config.nvim-cmp') end, 2000)
      end
    }

    -- TODO: Move to luasnip
    -- snippets
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
    use { "honza/vim-snippets", after = 'ultisnips'}
    use {"SirVer/ultisnips", config = function() require('user.config.ultisnips') end}

    -- lsp
    use {"neovim/nvim-lspconfig", after = "cmp-nvim-lsp"}
    use 'tamago324/nlsp-settings.nvim'
    use { "williamboman/mason.nvim", after = {"nvim-lspconfig", "nlsp-settings.nvim"} }
    use {
      "williamboman/mason-lspconfig.nvim",
      after = "mason.nvim",
      config = function() require('user.config.lsp.mason-lspconfig') end
    }

    -- json schemas for language server
    use "b0o/schemastore.nvim"

    -- colorscheme and sintax highlighting
    use "sainnhe/everforest"
    use 'shaunsingh/nord.nvim'
    use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter"}
    use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate', config = function() require('user.config.treesitter') end}

    -- directory management and navigation
    use {
      'kyazdani42/nvim-tree.lua',
      after ="nvim-web-devicons",
      config = function() require('user.config.nvim-tree') end
    }

    -- fuzzy search
    use {'nvim-telescope/telescope-symbols.nvim', after = "telescope.nvim"}
    use {"nvim-telescope/telescope-media-files.nvim"}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
      'nvim-telescope/telescope.nvim',
      after = {"plenary.nvim", "telescope-media-files.nvim", "telescope-fzf-native.nvim"},
      config = function() vim.defer_fn(function() require('user.config.telescope') end, 150) end
    }

    -- github copilot integration
    use {
      'github/copilot.vim',
      config = function() require('user.config.copilot') end
    }


    -- code commenting
    use {
      "vim-scripts/tComment",
      config = function() vim.defer_fn(function() require('user.config.t-comment') end, 2000) end
    }

    -- buffers management
    use {
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config = function() require('user.config.bufferline') end
    }

    -- centering on a current line
    use {
      "arnamak/stay-centered.nvim",
      config = function() require('stay-centered') end
    }

    -- version control: git
    use "mhinz/vim-signify"
    use { "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } }
    use {"tpope/vim-fugitive", config = function() require('user.config.vim-fugitive') end}
    -- when integration with fugitive comes
    -- use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Python plugins
    use { "Vimjas/vim-python-pep8-indent", ft = { "python" } }
    use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = function() require('user.config.hlslens') end
    }

    -- -- Stay after pressing * and search selected text
    use "haya14busa/vim-asterisk"

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      after = "nord.nvim" ,
      config = function() require('user.config.lualine') end
    }

    -- indent line
    use {"lukas-reineke/indent-blankline.nvim", config = function() require('user.config.indent-blankline') end}

    -- Highlight URLs inside vim
    use "itchyny/vim-highlighturl"

    -- navigate tags and lsp symbols
    use {"liuchengxu/vista.vim", config = function() vim.defer_fn(function() require('user.config.vista') end, 2000) end}

    -- Add nvim-autopairs
    use {"windwp/nvim-autopairs", after = "nvim-cmp", config = function() vim.defer_fn(function() require('user.config.nvim-autopairs') end, 2000) end}

    -- Repeat vim motions
    use "tpope/vim-repeat"

    -- -- Another markdown plugin
    use { "plasticboy/vim-markdown", ft = { "markdown" }, config = function() require('user.config.vim-markdown') end}
    --
    -- -- Faster footnote generation
    use { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" }}
    --
    -- -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    use { "godlygeek/tabular", cmd = { "Tabularize" } }

    -- -- markdown previewer
    use {
      "iamcco/markdown-preview.nvim",
      run = function() fn["mkdp#util#install"]() end,
      ft = { "markdown" },
    }

    -- Markdown JSON header highlight plugin
    use { "elzr/vim-json", ft = { "json", "markdown" }}

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
      config = function() require('user.config.neoscroll') end
    }

    -- vim sintax for toml
    use { "cespare/vim-toml", ft = { "toml" }, branch = "main" }

    -- The missing auto-completion for cmdline!
    use {"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]}

    -- Toggle terminal
    use {"akinsho/toggleterm.nvim", config = function() require('user.config.toggleterm') end}

    -- show and trim trailing whitespaces
    use 'jdhao/whitespace.nvim'

    -- better quickfix windows
    use({ "kevinhwang91/nvim-bqf", event = "FileType qf", config = function() vim.defer_fn(function() require('user.config.bqf') end, 2000) end})

    -- terraform
    -- use({"hashivim/vim-terraform"})

    -- ansible file detenction
    use({"pearofducks/ansible-vim"})

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)

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

-- TODO: fix imports and configuration so that they are ok
return packer.startup(function(use)

    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    -- package manager itself
    use{"wbthomason/packer.nvim", config = [[require('user.config.packer')]]}

    -- useful lua functions for plugins
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- notification plugin
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.defer_fn(function() require('user.config.nvim-notify') end, 2000)
      end
    })

    -- completions plugins
    use {"onsails/lspkind-nvim", event = "BufEnter"}
    use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('user.config.nvim-cmp')]]}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use "hrsh7th/cmp-nvim-lsp"
    use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}

    -- snippets
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
    use "SirVer/ultisnips"
    use({ "honza/vim-snippets", after = 'ultisnips'})

    -- lsp
    -- TODO: Change diagnostics to only necessary, short messages
    -- TODO: flake8 plugin does not take into accoutnt configuration fiel in tg-be environment, see whats up
    -- TODO: fix dependencies of nlsp-settings and so on
    -- TODO: See how to simplify installation of 3rd party plugins without going into server venv and installing them in there
    -- TODO: fix mypy-lsp polution with .mypyd files everywhere
    -- TODO: mypy-lsp not working in virtualenvironments ask on github
    use {"williamboman/nvim-lsp-installer", config = [[require('user.config.lsp.lsp_installer')]], after = "nvim-lspconfig"}
    use {"neovim/nvim-lspconfig", after = "cmp-nvim-lsp"}
    use { 'tamago324/nlsp-settings.nvim' }

    -- json schemas for language server
    use "b0o/schemastore.nvim"

    -- colorscheme and sintax highlighting
    use "sainnhe/everforest"
    use 'shaunsingh/nord.nvim'
    use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate', config = [[require('user.config.treesitter')]] }
    use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter"}

    -- directory management and navigation
    use {'kyazdani42/nvim-tree.lua', cmd = {"NvimTreeToggle"}, config = [[require('user.config.nvim-tree')]], after = "nvim-web-devicons"}

    -- fuzzy search
    use "nvim-telescope/telescope-media-files.nvim"
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope.nvim', after = {"plenary.nvim"}, config = [[require('user.config.telescope')]]}
    use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}

    -- code commenting
    use "vim-scripts/tComment"

    -- buffers management
    use {"akinsho/bufferline.nvim", config = [[require('user.config.bufferline')]], after = "nvim-web-devicons"}


    -- centering on a current line
    use {"arnamak/stay-centered.nvim", config = [[require('user.config.stay_centered')]]}

    -- version control: git
    use "mhinz/vim-signify"
    use "tpope/vim-fugitive"
    use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })
    -- when integration with fugitive comes
    -- use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Python plugins
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })
    use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

    -- interactive shell for testing programs
    use({ "hkupty/iron.nvim", ft = { "python" }, config = [[require('user.config.iron')]]})

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = [[require('user.config.hlslens')]]
    }

    -- -- Stay after pressing * and search selected text
    use "haya14busa/vim-asterisk"

    -- statusline
    use {'nvim-lualine/lualine.nvim', after = "nord.nvim" ,  config = [[require('user.config.lualine')]]}

    -- indent line
    use {"lukas-reineke/indent-blankline.nvim", config = [[require('user.config.indent-blankline')]]}

    -- Highlight URLs inside vim
    use "itchyny/vim-highlighturl"

    -- TODO: Autostart of vista
    -- TODO: dataclasses not showing ok in vistaplug
    -- navigate tags and lsp symbols
    use "liuchengxu/vista.vim"

    -- Add nvim-autopairs
    use {"windwp/nvim-autopairs", after = "nvim-cmp", config = [[require('user.config.nvim-autopairs')]]}

    -- Repeat vim motions
    use "tpope/vim-repeat"


    -- -- Another markdown plugin
    use({ "plasticboy/vim-markdown", ft = { "markdown" }, config = [[require('user.config.vim-markdown')]]})
    --
    -- -- Faster footnote generation
    use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })
    --
    -- -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    use({ "godlygeek/tabular", cmd = { "Tabularize" } })

    -- -- markdown previewer
    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        fn["mkdp#util#install"]()
      end,
      ft = { "markdown" },
    })

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

    -- Toggle terminal
    use {"akinsho/toggleterm.nvim", config = [[require('user.config.toggleterm')]]}

    --  TODO: Works but see why it is not working for F (telescope) mappings
    -- showing keybindings
    use {"folke/which-key.nvim",
      config = function()
        vim.defer_fn(function() require('user.config.which-key') end, 2000)
      end
    }

    -- show and trim trailing whitespaces
    use 'jdhao/whitespace.nvim'

    -- better quickfix windows
    use({ "kevinhwang91/nvim-bqf", event = "FileType qf", config = [[require('user.config.bqf')]] })

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)

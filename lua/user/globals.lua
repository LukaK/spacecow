-- local function file_exists(name)
local utils = require "user.utils"

-- define python 3 path
local python3_path = vim.fn.exepath("python")
local python3_pyenv_path = vim.env["PYENV_ROOT"] .. '/versions/py3nvim/bin/python'

if utils.file_exists(python3_pyenv_path) then
  python3_path = python3_pyenv_path
end

-- define global options
local glob_options = {
  -- python 3 provider
  python3_host_prog = python3_path,

  -- disable python2 provider
  loaded_python_provider = 0,

  -- disable perl provider
  loaded_perl_provider = 0,

  -- disable ruby provider
  loaded_ruby_provider = 0,

  -- disable node provider
  loaded_node_provider = 0,

  -- leader key
  mapleader = ",",
  maplocalleader = ",",

  -- enable highlighting for lua HERE doc inside vim script
  vimsyn_embed = 'l',

  -- use English as main language
  language = "en_US.utf-8",

  -- do not load tohtml.vim
  loaded_2html_plugin = 1,

  -- do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
  -- related to checking files inside compressed files)
  loaded_zipPlugin = 1,
  loaded_tarPlugin = 1,
  loaded_gzip = 1,

  -- do not load tutor plugin
  loaded_tutor_mode_plugin = 1,

  -- do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
  loaded_matchit = 1,
  loaded_matchparen = 1,

}

-- set global vim variables
for key,val in pairs(glob_options) do
  vim.g[key] = val
end

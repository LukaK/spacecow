-- local function file_exists(name)
function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

-- TODO: Add default provider if pyenv did not provided one
-- set python3 provider
local pyenv_root = vim.env["PYENV_ROOT"]
local python3_path = pyenv_root .. '/versions/py3nvim/python'

if file_exists(python3_path) then
  vim.g.python3_host_prog = python3_path
end


-- disable python2 provider
vim.g.loaded_python_provider = 0

-- disable perl provider
vim.g.loaded_perl_provider = 0

-- disable ruby provider
vim.g.loaded_ruby_provider = 0

-- disable node provider
vim.g.loaded_node_provider = 0

-- leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = 'l'

-- use English as main language
vim.g.language = "en_US.utf-8"

-- do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1

-- do not load tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- to configure new server put here only options that are programatically assigned
-- the rest of the options should be configured with nlsp settings

local schemastore = require "schemastore"
local nvim_lsp = require "lspconfig"


-- jsonls configuration
local jsonls_config = {settings = {json = {schemas = require('schemastore').json.schemas()}}}

-- pylsp configuration
-- to install python language server 3rd party plugins use PylspInstall command and a plugin you want
-- TODO: Instal flake8
local pylsp_config = {root_dir = nvim_lsp.util.root_pattern('.git'), flags = {debounce_text_changes = 200}}

-- vimls configuration
local vimls_config = {flags = {debounce_text_changes = 500}}

-- yamlls configuration
local yamlls_config = {filetypes = {"yaml", "yml"}, settings = {yaml = {schemas = schemastore.yaml.schemas()}}}

-- TODO: setup bash language server
local bashls_config = {}

-- TODO: Add dockerfile language server
local dockerls_config = {}

-- terraform language server
local terraform_ls_config = {}

-- ansible language server
-- TODO: Install ansible lint
local ansible_ls_config = {}

-- ansible language server
local helm_ls_config = {}

-- go language server
-- TODO: install delve and staticcheck
local gopls_config = {}

-- lua configuration
local lua_runtime_path = vim.split(package.path, ";")
table.insert(lua_runtime_path, "lua/?.lua")
table.insert(lua_runtime_path, "lua/?/init.lua")

local lua_config = {
  settings = {
    Lua = {
      runtime = {path = lua_runtime_path},
      workspace = {library = vim.api.nvim_get_runtime_file("", true)}
    },
  },
}

-- export options
local M = {}
-- to fix version use @ i.e. pylsp@1.7.4
M.server_versions = {"jsonls", "pylsp", "vimls", "yamlls", "lua_ls", "bashls", "dockerls", "terraformls", "ansiblels", "helm_ls", "gopls"}
M.options = {
  jsonls = jsonls_config,
  pylsp = pylsp_config,
  vimls = vimls_config,
  yamlls =yamlls_config,
  lua_ls = lua_config,
  bashls = bashls_config,
  dockerls = dockerls_config,
  terraformls = terraform_ls_config,
  ansiblels = ansible_ls_config,
  helm_ls = helm_ls_config,
  gopls = gopls_config,
}

return M

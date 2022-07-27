-- to configure new server put here only options that are programatically assigned
-- the rest of the options should be configured with nlsp settings

local utils = require "user.utils"

-- load bigger server configurations
local yamlls_status, schemastore = utils.vprequire("schemastore", "server_configs")
local nvim_lsp_status, nvim_lsp = utils.vprequire("lspconfig", "server_configs")

if not yamlls_status or not nvim_lsp_status then
  return
end


-- jsonls configuration
local jsonls_config = {settings = {json = {schemas = require('schemastore').json.schemas()}}}

-- pylsp configuration
local pylsp_config = {root_dir = nvim_lsp.util.root_pattern('.git'), flags = {debounce_text_changes = 200}}

-- vimls configuration
local vimls_config = {flags = {debounce_text_changes = 500}}

-- yamlls configuration
local yamlls_config = {filetypes = {"yaml", "yml"}, settings = {yaml = {schemas = schemastore.json.schemas()}}}

-- sumneko_lua configuration
local lua_runtime_path = vim.split(package.path, ";")
table.insert(lua_runtime_path, "lua/?.lua")
table.insert(lua_runtime_path, "lua/?/init.lua")

local sumneko_lua_config = {
  settings = {
    Lua = {
      runtime = {path = lua_runtime_path},
      workspace = {library = vim.api.nvim_get_runtime_file("", true)}
    },
  },
}

-- export options
local M = {}
M.options = {
  jsonls = jsonls_config,
  pylsp = pylsp_config,
  vimls = vimls_config,
  yamlls =yamlls_config,
  sumneko_lua = sumneko_lua_config
}

return M

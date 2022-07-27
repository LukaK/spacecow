local utils = require "user.utils"

-- load bigger server configurations
local yamlls_status, schemastore = utils.vprequire("schemastore", "server_configs")
local sumneko_lua_status, sumneko_lua_module = utils.vprequire("user.config.lsp.sumneko_lua", "server_configs")

if not sumneko_lua_status or not yamlls_status then
  return
end


local M = {}

-- TODO: Move all server configs level below and keep lsp settings in above level
local nvim_lsp = require 'lspconfig'
M.options = {

    -- jsonls settings
    jsonls = {settings = {json = {schemas = require('schemastore').json.schemas()}}},

    -- pylsp settings
    pylsp = {
      root_dir = nvim_lsp.util.root_pattern('.git'),
      flags = {debounce_text_changes = 200},
    },

    -- vimls settings
    vimls = {flags = {debounce_text_changes = 500}},

    -- ymalls settings
    yamlls ={
      filetypes = {"yaml", "yml"},
      settings = {yaml = {schemas = schemastore.json.schemas()}}
    },

    -- sumneko lua options
    sumneko_lua = sumneko_lua_module.options,
}

return M

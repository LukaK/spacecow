local utils = require "user.utils"

-- load bigger server configurations
local yamlls_status, schemastore = utils.vprequire("schemastore", "server_configs")
if not yamlls_status then
  return
end


local M = {}

-- lua runtime information
local lua_runtime_path = vim.split(package.path, ";")
table.insert(lua_runtime_path, "lua/?.lua")
table.insert(lua_runtime_path, "lua/?/init.lua")

local nvim_lsp = require 'lspconfig'
-- TODO: Move to sepparate tables for every server
-- TODO: Add comments how to configure servers
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
    sumneko_lua = {
      settings = {
        Lua = {
          -- Setup your lua path
          runtime = {path = lua_runtime_path},
          -- Make the server aware of Neovim runtime files
          workspace = {library = vim.api.nvim_get_runtime_file("", true)},
        },
      },
    },
}

return M

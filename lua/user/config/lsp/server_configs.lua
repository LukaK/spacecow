local utils = require "user.utils"

-- load bigger server configurations
local sumneko_lua_status, sumneko_lua_module = utils.vprequire("user.config.lsp.sumneko_lua", "server_configs")
local yamlls_status, yamlls_module = utils.vprequire("user.config.lsp.yamlls", "server_configs")

if not sumneko_lua_status or not yamlls_status then
  return
end


local M = {}

M.options = {

    -- clangd settings
    clangd = {
      filetypes = { "c", "cpp", "cc" },
      flags = {debounce_text_changes = 500},
    },

    -- jsonls settings
    jsonls = {
      settings = {
        json = {schemas = require('schemastore').json.schemas(),},
      },
    },

    -- pylsp settings
    pylsp = {
      settings = {
        pylsp = {
          plugins = {
            pylint = { enabled = true, executable = "pylint" },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            jedi_completion = { fuzzy = true },
            pyls_isort = { enabled = true },
            pylsp_mypy = { enabled = true },
          },
        },
      },
      flags = {debounce_text_changes = 200},
    },

    -- vimls settings
    vimls = {flags = {debounce_text_changes = 500}},

    -- ymalls settings
    yamlls = yamlls_module.options,

    -- sumneko lua options
    sumneko_lua = sumneko_lua_module.options,
}

return M

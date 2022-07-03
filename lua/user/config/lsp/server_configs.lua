local utils = require "user.utils"

-- load bigger server configurations
local sumneko_lua_status, sumneko_lua_module = utils.vprequire("user.config.lsp.sumneko_lua", "server_configs")
local yamlls_status, yamlls_module = utils.vprequire("user.config.lsp.yamlls", "server_configs")

if not sumneko_lua_status or not yamlls_status then
  return
end


local M = {}

M.options = {

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
            pylint = { enabled = false},
            pyflakes = { enabled = false },
            flake8 = { enabled = true },
            pycodestyle = { enabled = false },
            pydocstyle = { enabled = false },
            jedi_completion = { fuzzy = true },
            pyls_isort = { enabled = true },
            black = { enabled = true },
            -- TODO: mypy is not working in virtualenvironments
            pylsp_mypy = { enabled = false, live_mode = true },
            yapf = { enabled = false },
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

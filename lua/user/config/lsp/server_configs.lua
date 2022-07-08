local utils = require "user.utils"

-- load bigger server configurations
local sumneko_lua_status, sumneko_lua_module = utils.vprequire("user.config.lsp.sumneko_lua", "server_configs")
local yamlls_status, yamlls_module = utils.vprequire("user.config.lsp.yamlls", "server_configs")

if not sumneko_lua_status or not yamlls_status then
  return
end


local M = {}
local dev_config_path = vim.env["HOME"] .. "/.config/dev_tools"

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
            -- disable unnecessary plugins
            pylint = { enabled = false},
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            pydocstyle = { enabled = false },
            yapf = { enabled = false },

            jedi_completion = { fuzzy = true },
            black = { enabled = true, max_line_length = 80},
            pyls_isort = { enabled = true},
            -- TODO: when local configuration is enabled add config file to the settings
            flake8 = { enabled = true, config = dev_config_path .. "/flake8"},
            -- TODO: when local configuration is enabled add python-versio option to overrides in virtualenvironment
            pylsp_mypy = { enabled = true, live_mode = true, overrides = {"--config-file", dev_config_path .. "/mypy.ini", true} },

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

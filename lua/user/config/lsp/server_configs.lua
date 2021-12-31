-- load bigger server configurations
local sumneko_lua_status, sumneko_lua = pcall(require, "user.config.lsp.sumneko_lua")
if not sumneko_lua_status then
  print("Unable to load sumneko lua")
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
    yamlls = {
      filetypes = {"yaml", "yml"},
      settings = {yaml = {schemas = require('schemastore').json.schemas()}}
    },

    -- sumneko lua options
    sumneko_lua = sumneko_lua.options,
}

return M

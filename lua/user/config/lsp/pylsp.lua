-- load modules
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
local lsp_utils_status, lsp_utils = pcall(require, "user.config.lsp.lsp_utils")

-- TODO: Add dynamic message that has filename with a call
if not lspconfig_status or not lsp_utils_status then
  print("Unable to load modules in clangd lsp configuration...")
  return
end

-- configure server
lspconfig.pylsp.setup({
  on_attach = lsp_utils.custom_attach,
  capabilities = lsp_utils.capabilities,
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
  flags = {
    debounce_text_changes = 200,
  },
})

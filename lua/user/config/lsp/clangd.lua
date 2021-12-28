-- load modules
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
local lsp_utils_status, lsp_utils = pcall(require, "user.config.lsp.lsp_utils")

if not lspconfig_status or not lsp_utils_status then
  print("Unable to load modules in clangd lsp configuration...")
  return
end

-- configure server
lspconfig.clangd.setup({
  on_attach = lsp_utils.custom_attach,
  capabilities = lsp_utils.capabilities,
  filetypes = { "c", "cpp", "cc" },
  flags = {
    debounce_text_changes = 500,
  },
})

-- load modules
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
local lsp_utils_status, lsp_utils = pcall(require, "user.config.lsp.lsp_utils")

-- TODO: Add dynamic message that has filename with a call
if not lspconfig_status or not lsp_utils_status then
  print("Unable to load modules in clangd lsp configuration...")
  return
end

-- configure server
local sumneko_binary_path = vim.fn.exepath("lua-language-server")
if sumneko_binary_path == "" then
  print("Lua language server not installed")
  return
end

local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")
local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
  on_attach = lsp_utils.custom_attach,
  capabilities = lsp_utils.capabilities,
  cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

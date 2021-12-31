local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
local server_configs_status, server_configs = pcall(require, "user.config.lsp.server_configs")
local lsp_utils_status, lsp_utils = pcall(require, "user.config.lsp.utils")

-- TODO: Fix print to include more info where is the problem
-- TODO: Do you wan to use vim.notify or print
if not lsp_installer_status_ok or not server_configs_status  or not lsp_utils_status then
  print("Unable to load modules")
  return
end

-- install automatically servers for which you have configurations
for server_name, _ in pairs(server_configs.options) do
  local server_is_found, server = lsp_installer.get_server(server_name)
  if server_is_found then
    if not server:is_installed() then
      vim.notify("Installing " .. server_name, "info", {title = "nvim-lsp-installer"})
      server:install()
    end
  end
end

-- configure servers
-- lsp installer has to modify cmd path for servers so it
-- overwrites configurations passed with lspconfig plugin
lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {
    on_attach = lsp_utils.on_attach,
    capabilities = lsp_utils.capabilities,
  }

  -- augment servver options
  if server_configs.options[server.name] then
    for key, value in pairs(server_configs.options[server.name]) do
      opts[key] = value
    end
  end

  server:setup(opts)
end)

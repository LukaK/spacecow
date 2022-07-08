local utils = require "user.utils"
local server_configs_status, server_configs = utils.vprequire("user.config.lsp.server_configs", "nvim-lsp-installer")
local lsp_utils_status, lsp_utils = utils.vprequire("user.config.lsp.utils", "nvim-lsp-installer")
local lsp_installer_status_ok, lsp_installer = utils.vprequire("nvim-lsp-installer", "nvim-lsp-installer")
local nlspsettings_status, nlspsettings = utils.vprequire("lspconfig", "nvim-lsp-installer")
local nlspsettings_status, nlspsettings = utils.vprequire("nlspsettings", "nvim-lsp-installer")

-- TODO: Fix print to include more info where is the problem
-- TODO: Do you wan to use vim.notify or print
if not lsp_installer_status_ok or not server_configs_status  or not lsp_utils_status  or not nlspsettings_status then
  return
end

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

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

-- Specify the default options which we'll use to setup all servers
local common_setup_opts = {
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities,
}

-- configure servers
-- lsp installer has to modify cmd path for servers so it
-- overwrites configurations passed with lspconfig plugin
lsp_installer.on_server_ready(function(server)
  local opts = vim.deepcopy(common_setup_opts)

  -- augment servver options
  if server_configs.options[server.name] then
    opts = vim.tbl_deep_extend('force', opts, server_configs.options[server.name])
  end

  server:setup(opts)
end)

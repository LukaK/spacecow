local server_configs = require "user.config.lsp.server_configs"
local lsp_utils = require "user.config.lsp.utils"
local lsp_installer = require "nvim-lsp-installer"
local nlspsettings = require "nlspsettings"

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers = { '.git' },
  append_default_schemas = true,
  loader = 'json',
  nvim_notify = {enable = true}
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

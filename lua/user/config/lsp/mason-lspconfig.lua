local server_configs = require "user.config.lsp.server_configs"
local lsp_utils = require "user.config.lsp.utils"
local nlspsettings = require "nlspsettings"

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers = { '.git' },
  append_default_schemas = true,
  loader = 'json',
  nvim_notify = {enable = true}
})

-- configure servers
require("mason").setup {}
require("mason-lspconfig").setup {ensure_installed = server_configs.server_versions}

-- global server configs
local common_setup_opts = {
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities,
}

-- setup servers
for server_name, server_config in pairs(server_configs.options) do
  local opts = vim.deepcopy(common_setup_opts)
  opts = vim.tbl_deep_extend('force', opts, server_config)
  require("lspconfig")[server_name].setup(opts)
end

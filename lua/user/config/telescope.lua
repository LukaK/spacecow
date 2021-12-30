local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- load extension
telescope.load_extension("media_files")

telescope.setup {
  extensions = {
    media_files = {
     -- filetypes whitelist
     filetypes = {"png", "webp", "jpg", "jpeg"},
     find_cmd = "rg"
    },
  },
}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- telescope keybindings
keymap("n", "Ff", ":Telescope find_files<CR>", opts)
keymap("n", "Fg", ":Telescope live_grep<CR>", opts)
keymap("n", "Fm", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opts)

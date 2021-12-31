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

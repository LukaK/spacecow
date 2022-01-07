local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end


telescope.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
}

-- load extension
telescope.load_extension("media_files")
telescope.load_extension("fzf")

local utils = require "user.utils"
local status_ok, indent_blankline = utils.vprequire("indent_blankline", "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup({
  -- U+2502 may also be a good choice, it will be on the middle of cursor.
  -- U+250A is also a good choice
  char = "▏",
  show_end_of_line = true,
  disable_with_nolist = true,
  buftype_exclude = { "terminal" },
  filetype_exclude = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha" },
})

-- check if indentation line impact prductivity when present in insert mode
-- vim.cmd([[
-- function! Should_activate_indentblankline() abort
--   if index(g:indent_blankline_filetype_exclude, &filetype) == -1
--     IndentBlanklineEnable
--   endif
-- endfunction
--
-- augroup indent_blankline
--   autocmd!
--   autocmd InsertEnter * IndentBlanklineDisable
--   autocmd InsertLeave * call Should_activate_indentblankline()
-- augroup END
-- ]])

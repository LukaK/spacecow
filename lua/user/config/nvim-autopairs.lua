local nvim_autopairs = require "nvim-autopairs"

nvim_autopairs.setup({
  disable_filetype = { "TelescopePrompt" },
  disable_in_macro = false,  -- disable when recording or executing a macro
  disable_in_visualblock = false, -- disable when insert after visual block mode
  enable_moveright = true,
  enable_afterquote = true,  -- add bracket pairs after quote
  enable_check_bracket_line = false,  --- check bracket in same line
  map_bs = true,  -- map the <BS> key
  map_c_h = false,  -- Map the <C-h> key to delete a pair
  map_c_w = false, -- map <c-w> to delete a pair if possible
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
  fast_wrap = {
    map = '<C-w>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },

  check_ts = true,
  ts_config = {
    lua = {'string', "source"},
  }
})

-- If you want insert `(` after select function or method item
local status_ok_cmp, cmp = pcall(require, "cmp")
if status_ok_cmp then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
end


local Rule = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'

nvim_autopairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col -1, opts.col)
      return vim.tbl_contains({ '()', '{}', '[]' }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
    end),
  Rule('', ' )')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ')' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(')'),
  Rule('', ' }')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == '}' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key('}'),
  Rule('', ' ]')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ']' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(']'),
  Rule('=', '')
    :with_pair(cond.not_inside_quote())
    :with_pair(function(opts)
      local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
      if last_char:match('[%w%=%s]') then
        return true
      end
      return false
    end)
    :replace_endpair(function(opts)
      local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
      local next_char = opts.line:sub(opts.col, opts.col)
      next_char = next_char == ' ' and '' or ' '
      if prev_2char:match('%w$') then
        return '<bs> =' .. next_char
      end
      if prev_2char:match('%=$') then
        return next_char
      end
      if prev_2char:match('=') then
        return '<bs><bs>=' .. next_char
      end
      return ''
    end)
    :set_end_pair_length(0)
    :with_move(cond.none())
    :with_del(cond.none())
}

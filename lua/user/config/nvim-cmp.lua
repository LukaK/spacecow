local cmp = require "cmp"
local lspkind = require "lspkind"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `ultisnips` user.
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          -- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          --   vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          -- elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          --   return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
    -- s = function(fallback)
    --   if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    --     return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
    --   else
    --     fallback()
    --   end
    -- end
    }),

    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end
    }),

    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
  },
  sources = {
    { name = 'nvim_lsp' }, -- For nvim-lsp
    { name = 'ultisnips' }, -- For ultisnips user.
    { name = 'nvim_lua' }, -- for nvim lua function
    { name = 'path' }, -- for path completion
    { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
    { name = 'cmdline' }, -- for vim cmdline
  },
  completion = {
    keyword_length = 1,
    completeopt = "menu,noselect"
  },
  experimental = {
    ghost_text = false
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      menu = {
        nvim_lsp = "[Lsp]",
        ultisnips = "[Snip]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        buffer = "[Buffer]",
        cmdline = "[Cmd]",
      },
    }),
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  completion = { autocomplete = false },
  sources = {
    -- { name = 'buffer' }
    { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = { autocomplete = false },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- highlight group
vim.cmd("hi link CmpItemMenu Comment")

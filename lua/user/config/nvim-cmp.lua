-- load cmp module
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

-- load lspkind formatter
local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
  return
end

-- local luasnip = require "luasnip"

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `ultisnips` user.
      vim.fn["UltiSnips#Anon"](args.body)
      -- lua-snippets
      -- luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    -- ['<Esc>'] = cmp.mapping.close(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },
  sources = {
    { name = 'nvim_lsp' }, -- For nvim-lsp
    -- { name = 'luasnip' }, -- For luasnip user.
    { name = 'ultisnips' }, -- For ultisnips user.
    { name = 'nvim_lua' }, -- for nvim lua function
    { name = 'path' }, -- for path completion
    { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
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
        nvim_lsp = "[LSP]",
        ultisnips = "[US]",
        -- luasnip = "[SNP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        buffer = "[Buffer]",
      },
    }),
  },
})

vim.cmd("hi link CmpItemMenu Comment")

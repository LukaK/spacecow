-- mapping shorthands
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- easy save
keymap("n", "<leader>w", ":<C-U>update<CR>", opts)

-- saves the file if modified and quit
keymap("n", "<leader>q", ":<C-U>x<CR>", opts)

-- quit all open buffers
keymap("n", "<leader>Q", ":<C-U>qa!<CR>", opts)

-- telescope keybindings
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fm", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opts)
keymap("n", "Ff", ":Telescope find_files<CR>", opts)
keymap("n", "Fg", ":Telescope live_grep<CR>", opts)
keymap("n", "Fm", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opts)

-- " Navigation in the location and quickfix list
-- nnoremap <silent> [l :<C-U>lprevious<CR>zv
-- nnoremap <silent> ]l :<C-U>lnext<CR>zv
-- nnoremap <silent> [L :<C-U>lfirst<CR>zv
-- nnoremap <silent> ]L :<C-U>llast<CR>zv
-- nnoremap <silent> [q :<C-U>cprevious<CR>zv
-- nnoremap <silent> ]q :<C-U>cnext<CR>zv
-- nnoremap <silent> [Q :<C-U>cfirst<CR>zv
-- nnoremap <silent> ]Q :<C-U>clast<CR>zv

-- close location list or quickfix list if they are present,
-- see https://superuser.com/q/355325/736190
keymap("n", "\\x", ":<C-U>windo lclose <bar> cclose <CR>", opts)

-- close a buffer and switching to another buffer, do not close the
-- window, see https://stackoverflow.com/q/4465095/6064933
keymap("n", "\\d", ":<C-U>bprevious <bar> bdelete #<CR>", opts)

-- " Move the cursor based on physical lines, not the actual lines.
-- nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
-- nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
-- nnoremap ^ g^
-- nnoremap 0 g0

-- do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
keymap("x", "$", "g_", opts)

-- jump to matching pairs easily in normal mode
keymap("n", "<Tab>", "%", opts)

-- window movements
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)


-- continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap("x", ">", ">gv", opts)
keymap("x", "<", "<gv", opts)

-- " Tab-complete, see https://vi.stackexchange.com/q/19675/15292.
-- inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
-- inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

-- " Edit and reload init.vim quickly
-- nnoremap <silent> <leader>ev :<C-U>tabnew $MYVIMRC <bar> tcd %:h<cr>
-- nnoremap <silent> <leader>sv :<C-U>silent update $MYVIMRC <bar> source $MYVIMRC <bar>
--       \ call v:lua.vim.notify("Nvim config successfully reloaded!", 'info', {'title': 'nvim-config'})<cr>

-- reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
-- nnoremap <expr> <leader>v printf('`[%s`]', getregtype()[0])

-- " Search in selected region
-- xnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

-- TODO: Implement after the support
-- -- find and replace (like Sublime Text 3)
-- keymap("n", "<leader>ss", ":%s/", opts)
-- keymap("x", "<leader>ss", ":s/", opts)

-- use Esc to quit builtin terminal
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
-- keymap("n", "c", "_c", opts)
-- keymap("n", "C", "_C", opts)
-- keymap("n", "cc", "_cc", opts)
-- keymap("x", "c", "_c", opts)

-- " Clear highlighting
-- if maparg('<C-L>', 'n') ==# ''
--   nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
-- endif

-- buffer movements
-- nnoremap <silent> gb :<C-U>call buf_utils#GoToBuffer(v:count, 'forward')<CR>
-- nnoremap <silent> gB :<C-U>call buf_utils#GoToBuffer(v:count, 'backward')<CR>
-- nnoremap <Left> <C-W>h
-- nnoremap <Right> <C-W>l
-- nnoremap <Up> <C-W>k
-- nnoremap <Down> <C-W>j

-- " Text objects for URL
-- xnoremap <silent> iu :<C-U>call text_obj#URL()<CR>
-- onoremap <silent> iu :<C-U>call text_obj#URL()<CR>

-- " Break inserted text into smaller undo units.
-- for ch in [',', '.', '!', '?', ';', ':']
--   execute printf('inoremap %s %s<C-g>u', ch, ch)
-- endfor



-- nvim-tree mappings
keymap("n", "<leader>F", ":NvimTreeToggle<CR>", opts)

-- vista mappings
keymap("n", "<leader>f", ":Vista!!<CR>", opts)

-- t-comment mappings
keymap("n", "<leader>c", ":TComment<CR>", opts)
keymap("v", "<leader>c", ":TCommentMaybeInline<CR>", opts)

-- TODO: Change for another snippets
-- ultisnips mappings
vim.g.UltiSnipsEnableSnipMate = 0
vim.g.UltiSnipsExpandTrigger = '<leader>e'
vim.g.UltiSnipsJumpForwardTrigger = '<leader>a'
vim.g.UltiSnipsJumpBackwardTrigger = '<leader>b'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}

-- bufferline
keymap("n", "<Right>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<Left>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-Right>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<S-Left>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "gb", ":BufferLinePick<CR>", opts)

-- -- vim-fugitive mappings
keymap("n", "<leader>G", ":Git<CR>", opts)

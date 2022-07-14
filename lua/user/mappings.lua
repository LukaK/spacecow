-- mapping shorthands
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- remap for easy access to command mode
keymap("n", ";", ":", opts)
keymap("x", ";", ":", opts)

-- easy save
keymap("n", "<leader>s", ":<C-U>update<CR>", opts)

-- saves the file if modified and quit
keymap("n", "<leader>q", ":<C-U>x<CR>", opts)

-- quit all open buffers
keymap("n", "<leader>Q", ":<C-U>qa!<CR>", opts)

-- " Navigation in the location and quickfix list
keymap("n", "[l", ":<C-U>lprevious<CR>zv", opts)
keymap("n", "]l", ":<C-U>lnext<CR>zv", opts)
keymap("n", "[L", ":<C-U>lfirst<CR>zv", opts)
keymap("n", "]L", ":<C-U>lfirst<CR>zv", opts)
keymap("n", "[q", ":<C-U>cprevious<CR>zv", opts)
keymap("n", "]q", ":<C-U>cnext<CR>zv", opts)
keymap("n", "[Q", ":<C-U>cfirst<CR>zv", opts)
keymap("n", "]Q", ":<C-U>cfirst<CR>zv", opts)

-- close location list or quickfix list if they are present,
-- see https://superuser.com/q/355325/736190
keymap("n", "\\x", ":<C-U>windo lclose <bar> cclose <CR>", opts)

-- close a buffer and switching to another buffer, do not close the
-- window, see https://stackoverflow.com/q/4465095/6064933
keymap("n", "\\d", ":<C-U>bprevious <bar> bdelete #<CR>", opts)

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

-- " Search in selected region
keymap("x", "/", [[:<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>]], opts)

-- use Esc to quit builtin terminal
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap("n", "c", "\"_c", opts)
keymap("n", "C", "\"_C", opts)
keymap("n", "cc", "\"_cc", opts)
keymap("x", "c", "\"_c", opts)

-- replace visual selection with text in register, but not contaminate the
-- register, see also https://stackoverflow.com/q/10723700/6064933.
keymap("x", "p", "\"_c<ESC>p", opts)

-- TODO: Move all mappings to their corresponding configurations

-- nvim-tree mappings
keymap("n", "<leader>F", ":NvimTreeToggle<CR>", opts)

-- t-comment mappings
keymap("n", "<leader>c", ":TComment<CR>", opts)
keymap("v", "<leader>c", ":TCommentMaybeInline<CR>", opts)

-- bufferline keybindings
keymap("n", "<Right>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<Left>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-Right>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<S-Left>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "gb", ":BufferLinePick<CR>", opts)

-- telescope keybindings
keymap("n", "Ff", ":Telescope git_files<CR>", opts)
keymap("n", "FF", ":Telescope find_files hidden=true<CR>", opts)
keymap("n", "Fg", ":Telescope live_grep<CR>", opts)
keymap("n", "FG", ":lua require('telescope.builtin').live_grep({additional_args=function() return {'--hidden'} end})<cr>", opts)
keymap("n", "Fm", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opts)

-- ultisnips mappings
vim.g.UltiSnipsEnableSnipMate = 0
vim.g.UltiSnipsExpandTrigger = '<leader>e'
vim.g.UltiSnipsJumpForwardTrigger = '<leader>a'
vim.g.UltiSnipsJumpBackwardTrigger = '<leader>b'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}

-- vista mappings
keymap("n", "<leader>f", ":Vista!!<CR>", opts)

-- -- vim-fugitive mappings
keymap("n", "<leader>G", ":Git<CR>", opts)

-- insert newline from normal mode without going to insert mode
keymap("n", "<leader><CR>", "m`o<ESC>", opts)

-- toggle spell checking (autosave does not play well with z=, so we disable it
-- when we are doing spell checking)
keymap("n", "<F3>", ":<C-U> set spell!<CR>", opts)
keymap("i", "<F3>", ":<C-U> set spell!<CR>", opts)

-- TODO: See if this works for reloading
-- reload vim source files
keymap("n", "<leader>R", ":runtime! " .. vim.fn.stdpath("config") .. "/lua/user/**/*.lua<CR>", opts)

-- remove highlights
keymap("n", "<esc>", ":nohlsearch<cr>", opts)

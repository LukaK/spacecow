-- construct wildignore option value
local wildignore_value = vim.opt.wildignore + {'*.o', '*.obj', '*.dylib', '*.bin', '*.dll', '*.exe', '*/.git/*', '*/.svn/*', '*/__pycache__/*', '*/build/**'}
wildignore_value = wildignore_value + {'*.jpg', '*.png', '*.jpeg', '*.bmp', '*.gif', '*.tiff', '*.svg', '*.ico'}
wildignore_value = wildignore_value + {'*.pyc', '*.pkl'}
wildignore_value = wildignore_value + {'*.DS_Store'}
wildignore_value = wildignore_value + {'*.aux', '*.bbl', '*.blg', '*.brf', '*.fls', '*.fdb_latexmk', '*.synctex.gz', '*.xdv'}

-- define options table
local options = {
  -- change fillchars for folding, vertical split, end of buffer, and message separator
  fillchars = { fold = "\\",vert = "│", eob = " ", msgsep = "‾" },

  -- split window below/right when creating horizontal/vertical windows
  splitbelow = true,
  splitright = true,

  -- time in milliseconds to wait for a mapped sequence to complete,
  -- see https://unix.stackexchange.com/q/36882/221410 for more info
  timeoutlen = 500,

  -- for CursorHold events
  updatetime = 500,

  -- set clipboard
  clipboard = vim.opt.clipboard + "unnamedplus",
  
  -- disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
  swapfile = false,

  -- ignore certain files and folders when globing
  wildignore = wildignore_value,

  -- ignore file and dir name cases in cmd-completion
  wildignorecase = true,

  -- general tab settings
  -- number of visual spaces per TAB
  tabstop = 4,
  -- number of spaces in tab when editing
  softtabstop = 4,
  -- number of spaces to use for autoindent
  shiftwidth = 4,
  -- expand tab to spaces so that tabs are spaces
  expandtab = true,

  -- set matching pairs of characters and highlight matching brackets
  matchpairs = vim.opt.matchpairs + {"<:>","「:」","『:』","【:】","“:”","‘:’","《:》"},

  -- number column
  number = true,
  relativenumber = true,

  -- case sensitive search
  ignorecase = true,
  smartcase = true,

  -- file and script encoding settings for vim
  fileencoding = "utf-8",
  fileencodings = {"ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1"},

  -- break line at predefined characters
  linebreak = true,
  -- character to show before the lines that have been soft-wrapped
  showbreak = '↪',

  -- list all matches and complete till longest common string
  wildmode = { "list:longest" },

  -- use mouse to select and resize windows, etc.
  mouse = "nic",  --  Enable mouse in several mode
  mousemodel = "popup",  -- Set the behaviour of mouse

  -- disable showing current mode on command line since statusline plugins can show it.
  showmode = false,

  -- fileformats to use for new files
  fileformats = {"unix", "dos"},

  -- ask for confirmation when handling unsaved or read-only files
  confirm = true,

  -- do not use visual and errorbells
  visualbell = true,
  errorbells = false,

  -- the number of command and search history to keep
  history = 500,

  -- use list mode and customized listchars
  list = true,
  listchars={tab = '▸ ', extends = '❯', precedes = '❮', nbsp = '␣'},
  
  -- auto-write the file based on some condition
  autowrite = true,
  
  -- persistent undo even after you close a file and re-open it
  undofile = true,
  
  -- do not show "match xx of xx" and other messages during auto-completion
  -- do not show search match count on bottom right (seriously, I would strain my
  -- neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
  shortmess = vim.opt.shortmess + "c" + "S",

  -- completion behaviour
  -- set completeopt+=noinsert  " Auto select the first completion entry
  completeopt = vim.opt.completeopt + "menuone",  -- show menu even if there is only one item
  -- set completeopt-=preview  " Disable the preview window
  
  -- maximum number of items to show in popup menu
  pumheight = 10,
  
  -- pseudo transparency for completion menu
  pumblend = 10,
  
  -- pseudo transparency for floating window
  winblend = 5,
  
  -- insert mode key word completion setting
  complete = vim.opt.complete + "kspell" - "w" - "b" - "u" - "t",
  
  -- spell languages
  spelllang = {"en", "cjk"},
  
  -- show 9 spell suggestions at most
  spellsuggest = vim.opt.spellsuggest + "9",
  
  -- align indent to next multiple value of shiftwidth. For its meaning,
  -- see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
  shiftround = true,
  
  -- virtual edit is useful for visual block edit
  virtualedit = "block",
  
  -- correctly break multi-byte characters such as CJK,
  -- see https://stackoverflow.com/q/32669814/6064933
  formatoptions = vim.opt.formatoptions + "mM",
  
  -- text after this column number is not highlighted
  synmaxcol = 200,
  startofline = false,
  
  -- enable true color support. Do not set this option if your terminal does not
  -- support true colors! For a comprehensive list of terminals supporting true
  -- colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
  termguicolors = true,
  
  -- set up cursor color and shape in various mode, ref:
  -- https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
  guicursor = {"n-v-c:block-Cursor/lCursor", "i-ci-ve:ver25-Cursor2/lCursor2", "r-cr:hor20", "o:hor20"},

  signcolumn = "auto:2",
  
  -- remove certain character from file name pattern matching
  isfname = vim.opt.isfname - '=' - ',',
  
  -- diff options
  -- show diff in vertical position
  -- show filler for deleted lines
  -- turn off diff when one file window is closed
  -- context for diff
  diffopt = {"vertical", "filler", "closeoff", "context:3", "internal", "indent-heuristic", "algorithm:histogram"},
  
  -- do no wrap
  wrap = false,

}

-- TODO: Rewrite this to lua
-- " Clipboard settings, always use clipboard for all delete, yank, change, put
-- " operation, see https://stackoverflow.com/q/30691466/6064933
-- if !empty(provider#clipboard#Executable())
--   set clipboard+=unnamedplus
-- endif
-- -- set up backup directory
-- let g:backupdir=expand(stdpath('data') . '/backup//')
-- let &backupdir=g:backupdir
-- " Skip backup for patterns in option wildignore
-- let &backupskip=&wildignore
-- set backup  " create backup for files
-- set backupcopy=yes  " copy the original file to backupdir and overwrite it
-- show hostname, full path of file and last-mod time on the window title. The
-- -- meaning of the format str for strftime can be found in
-- -- http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
-- -- lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
-- title = true,
-- titlestring = "",
-- titlestring=%{utils#Get_titlestr()}
-- " External program to use for grep command
-- if executable('rg')
--   set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
--   set grepformat=%f:%l:%c:%m
-- endif
--
for k, v in pairs(options) do
  vim.opt[k] = v
end

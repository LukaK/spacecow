" Do r r not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
augroup dynamic_smartcase
  autocmd!
  autocmd CmdLineEnter : set nosmartcase
  autocmd CmdLineLeave : set smartcase
augroup END

augroup term_settings
  autocmd!
  " Do not use number and relative number for terminal inside nvim
  autocmd TermOpen * setlocal norelativenumber nonumber
  " Go to insert mode by default to start typing command
  autocmd TermOpen * startinsert
augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
  autocmd!
  autocmd BufReadPost * call s:resume_edit_pos()
augroup END

" Only resume last edit position when there is no go-to-line command (something like '+23').
function s:resume_edit_pos() abort
  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    let l:args = v:argv  " command line arguments
    for l:cur_arg in l:args
      " Check if a go-to-line command is given.
      let idx = match(l:cur_arg, '\v^\+(\d){1,}$')
      if idx != -1
        return
      endif
    endfor

    execute "normal! g`\"zvzz"
  endif
endfunction

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
augroup non_utf8_file_warn
  autocmd!
  " we can not use `lua vim.notify()`: it will error out E5107 parsing lua.
  autocmd BufRead * if &fileencoding != 'utf-8' | call v:lua.vim.notify('File not in UTF-8 format!', 'warn', {'title': 'nvim-config'}) | endif
augroup END

" Automatically reload the file if it is changed outside of Nvim, see
" https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" command does not work in command line. We need to check if we are in command
" line before executing this command. See also
" https://vi.stackexchange.com/a/20397/15292.
augroup auto_read
  autocmd!
  autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'nvim-config'})
  autocmd FocusGained,CursorHold * if getcmdwintype() == '' | checktime | endif
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Define or override some highlight groups
" augroup custom_highlight
"   autocmd!
"   autocmd ColorScheme * call s:custom_highlight()
" augroup END
"
" function! s:custom_highlight() abort
"   " For yank highlight
"   highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71
"
"   " For cursor colors
"   highlight Cursor cterm=bold gui=bold guibg=#00c918 guifg=black
"   highlight Cursor2 guifg=red guibg=red
"
"   " For floating windows border highlight
"   highlight FloatBorder guifg=LightGreen guibg=NONE
"
"   " highlight for matching parentheses
"   highlight MatchParen cterm=bold,reverse,underline gui=bold,reverse,underline
" endfunction

" " highlight yanked region, see `:h lua-highlight`
" augroup highlight_yank
"   autocmd!
"   au TextYankPost * silent! lua vim.highlight.on_yank{higroup="YankColor", timeout=300, on_visual=false}
" augroup END

" TODO: Maybe it is neccesary
" augroup git_repo_check
"   autocmd!
"   autocmd VimEnter,DirChanged * call utils#Inside_git_repo()
" augroup END

" Center cursor on movement
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2 + 1
augroup END
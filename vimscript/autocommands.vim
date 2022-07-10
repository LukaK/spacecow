" TODO: Rewrite this to lua
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

" TODO: Rewrite this fully in lua file
" " Automatically reload the file if it is changed outside of Nvim, see
" " https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" " command does not work in command line. We need to check if we are in command
" " line before executing this command. See also
" " https://vi.stackexchange.com/a/20397/15292.
" augroup auto_read
"   autocmd!
"   autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'nvim-config'})
"   autocmd FocusGained,CursorHold * if getcmdwintype() == '' | checktime | endif
" augroup END

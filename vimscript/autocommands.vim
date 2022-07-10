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

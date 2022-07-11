-- autoclose nvim tree if it is the last thing
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

-- more accurate syntax highlighting
vim.api.nvim_create_autocmd("BufEnter", { nested = true, callback = function() vim.api.nvim_command("syntax sync fromstart") end })

-- relative number toggle on focus
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, { nested = true, callback = function() if (vim.opt_local.number) then vim.opt_local.relativenumber = true end end })
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, { nested = true, callback = function() if (vim.opt_local.number) then vim.opt_local.relativenumber = false end end })

-- do not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
vim.api.nvim_create_autocmd("CmdLineEnter", { nested = true, callback = function() vim.api.nvim_set_option("smartcase", false) end })
vim.api.nvim_create_autocmd("CmdLineLeave", { nested = true, callback = function() vim.api.nvim_set_option("smartcase", true) end })

-- terminal settings
vim.api.nvim_create_autocmd("TermOpen", { nested = true, callback = function() vim.api.nvim_command("startinsert") end })
vim.api.nvim_create_autocmd("TermOpen", {
  nested = true,
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end
})

-- TODO: Fix this so that you use nvim notify plugin ( plugins should be loaded first? )
-- display a message when the current file is not in utf-8 format.
vim.api.nvim_create_autocmd("BufRead", {
  nested = true,
  callback = function()
    if (vim.api.nvim_buf_get_option(0, "fileencoding") ~= "utf-8")
    then
      vim.notify("File not in UTF-8 format!", "warn", {title = "nvim-config"})
    end
  end
})


-- automatically reload the file if it is changed outside of Nvim, see
-- https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
-- command does not work in command line. We need to check if we are in command
-- line before executing this command. See also https://vi.stackexchange.com/a/20397/15292.
vim.api.nvim_create_autocmd(
  "FileChangedShellPost",
  { nested = true, callback = function() vim.notify("File changed on disk. Buffer reloaded!", 'warn', {title = 'nvim-config'}) end }
)
vim.api.nvim_create_autocmd({"FocusGained", "CursorHold"}, {
  nested = true,
  callback = function() if (vim.api.nvim_exec("call getcmdwintype()", true) ==  "") then vim.api.nvim_command("checktime") end end
})


-- resume edit position
vim.cmd[[
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

  augroup resume_edit_position
    autocmd!
    autocmd BufReadPost * call s:resume_edit_pos()
  augroup END
]]

-- luacheck: ignore QF_SYNTAX_INITIALIZED
QF_SYNTAX_INITIALIZED = false
if not QF_SYNTAX_INITIALIZED then
  return
end

vim.cmd([[syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft]])
vim.cmd([[syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr]])
vim.cmd([[syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight]])
vim.cmd([[syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote]])
vim.cmd([[syn match qfError / E .*$/ contained]])
vim.cmd([[syn match qfWarning / W .*$/ contained]])
vim.cmd([[syn match qfInfo / I .*$/ contained]])
vim.cmd([[syn match qfNote / [NH] .*$/ contained]])

vim.cmd([[hi def link qfFileName Directory]])
vim.cmd([[hi def link qfSeparatorLeft Delimiter]])
vim.cmd([[hi def link qfSeparatorRight Delimiter]])
vim.cmd([[hi def link qfLineNr LineNr]])
vim.cmd([[hi def link qfError CocErrorSign]])
vim.cmd([[hi def link qfWarning CocWarningSign]])
vim.cmd([[hi def link qfInfo CocInfoSign]])
vim.cmd([[hi def link qfNote CocHintSign]])

QF_SYNTAX_INITIALIZED = true

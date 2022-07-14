vim.cmd([[
  setlocal ts=4 sts=4 sw=4 noexpandtab
  noremap <buffer> <localleader>; mmA;<esc>`m
  noremap <buffer> d][ V][d
  imap <buffer> <localleader>j <esc>o{<enter>
]])

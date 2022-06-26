vim.cmd([[
  setlocal ts=4 sts=4 sw=4 noexpandtab
  set colorcolumn=88
  highlight ColorColumn ctermbg=darkgray
  noremap <buffer> <localleader>; mmA;<esc>`m
  imap <buffer> ,j <esc>o{<enter>
]])

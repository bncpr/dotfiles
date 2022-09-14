vim.cmd([[
  setlocal ts=4 sts=4 sw=4 noexpandtab
  noremap <buffer> <localleader>; mmA;<esc>`m
  imap <buffer> <localleader>j <esc>o{<enter>
  map <buffer> <localleader>d $xo{<enter>
  let @t="dwea_t"
  noremap <buffer> <localleader>d] V][d
  command! RemoveRC :%s/int rc = \(.*\);\n\s*if (rc)/if (\1)/e
]])

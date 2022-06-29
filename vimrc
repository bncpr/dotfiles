if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let mapleader=","
let localleader="\\"
set mouse=a
syntax on
set number
set smartcase
nnoremap Y Y
nnoremap - ddp
nnoremap _ ddkP
inoremap <c-u> <esc>viwUea
nnoremap <leader>a; mmA;<esc>`m
nnoremap <leader>a, mmA,<esc>`m
nnoremap <leader>a: mmA:<esc>`m
nnoremap <leader>re mm$x`m
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
inoremap jk <esc>
noremap \ ,
nnoremap <leader>N :nohlsearch<cr>
nmap <leader>ob o{<cr>

autocmd! BufWrite vimrc source % | echom "reloaded $MYVIMRC"

set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif

augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

" Vimscript file settings ------------------------------------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vimrc,vim setlocal foldmethod=marker
  autocmd FileType vimrc,vim setlocal foldlevelstart=0
augroup END
" }}}

" Navigation settings ----------------------------------------------------- {{{
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" :terminal navigation
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif
" }}}

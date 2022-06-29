" Plugins {{{
call plug#begin()

Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'takac/vim-hardtime'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-operator-user'
Plug 'bfrg/vim-cpp-modern'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'wellle/targets.vim'
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'tell-k/vim-autopep8'
Plug 'honza/vim-snippets'
call plug#end()

" }}}

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let mapleader=","
let localleader="\\"
set mouse=a
set cc=80
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

" Theme settings {{{
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Onedark options
let g:onedark_termcolors = 16
let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1

" Hardtime options
" let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1

" Airline options
let g:airline#extensions#tabline#enabled = 1

colorscheme onedark
" }}}

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

syntax on
filetype plugin indent on

set nocompatible
set encoding=utf-8
set number
set autoindent
set showcmd
set autoread
set clipboard=unnamedplus
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set expandtab
set showmatch
set wildmenu
set smarttab
set ruler
set confirm
set hlsearch
set incsearch
set ignorecase
set smartcase

map <C-t> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <space> /
map q :quit<CR>

let g:NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

highlight Comment ctermfg=green

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

inoremap jj <Esc>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufWritePre * :%s/\s\+$//e
autocmd FocusGained,BufEnter * :silent! !

command! W w
command! WQ wq
command! Wq wq
command! Q q

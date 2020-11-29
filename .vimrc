"call plug#begin('~/.vim/plugged')
"
"call plug#end()

syntax on
filetype plugin indent on

set nocompatible
set encoding=utf-8
set autoread
set clipboard=unnamedplus
set expandtab
set number
set showcmd
set showmatch
set hlsearch
set wildmenu
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set autoindent
set smarttab
set ruler

"map <C-t> :NERDTreeToggle<CR>
"map <C-p> :Files<CR>
map <space> /

"let g:NERDTreeMinimalUI=1
"let g:NERDTreeQuitOnOpen = 1
"let NERDTreeShowHidden=1

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

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'

" Initialize plugin system
call plug#end()

syntax on
set termguicolors
set background=dark
colorscheme nord

set encoding=UTF-8
set nocompatible
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set showcmd
set guifont=Source\ Code\ Pro\ 14
set hidden

map <C-t> :NERDTreeToggle<CR>

command! Q q
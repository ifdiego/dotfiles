" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'

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
set nobackup
set nowritebackup

map <C-t> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

let g:closetag_filenames = '*.html,*.jsx,*.tsx'

let g:indentLine_fileTypeExclude=['help']
let g:indentLine_bufNameExclude=['NERD_tree.*']

let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1

command! Q q
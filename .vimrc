" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()

" Theme
syntax on
set termguicolors
set background=dark
set guifont=Source\ Code\ Pro\ 14
colorscheme nord

" General
set encoding=utf-8
set nocompatible
set autoread
set clipboard=unnamedplus
set expandtab
set number
set cursorline
set showcmd
set showmatch
set incsearch
set hlsearch
set wildmenu
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set textwidth=80
set autoindent

" Mappings
map <C-t> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
map <space> /

" NERDTree configuration
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1

" Lightline configuration
let g:lightline = { 'colorscheme': 'nord' }

" Don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Really, just don't
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Remap escape key
inoremap jj <Esc>

" Autocmds
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Typo prevention
command! W w
command! Q q

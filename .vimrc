" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'lervag/vimtex'
Plug 'dense-analysis/ale'
Plug 'rhysd/vim.wasm'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'rhysd/vim-clang-format'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'raphamorim/lucario'
Plug 'cocopon/iceberg.vim'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'jonathanfilip/vim-lucius'
Plug 'cormacrelf/vim-colors-github'

" Initialize plugin system
call plug#end()

syntax on
set termguicolors
set background=dark
" colorscheme nord
" colorscheme gotham
" colorscheme onedark
" colorscheme one
colorscheme lucario
" colorscheme iceberg

set encoding=UTF-8
set fileencoding=UTF-8
set nocompatible
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set cursorline
set showcmd
set guifont=Source\ Code\ Pro\ 14
set hidden
set nobackup
set nowritebackup
set laststatus=2
set autoread
set showmatch
set ruler
set textwidth=80

map <C-t> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

let g:closetag_filenames = '*.html,*.jsx,*.tsx'

let g:indentLine_fileTypeExclude=['help']
let g:indentLine_bufNameExclude=['NERD_tree.*']

let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1

if $TERM == "xterm-256color"
  set t_Co=256
endif

" Copy and paste to/from VIM and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" Access system clipboard
set clipboard=unnamed

" Don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Really, just don't
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

command! Q q

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
call plug#end()

syntax on
filetype plugin indent on

set number
set autoindent
set backspace=indent,eol,start
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch
set ignorecase
set incsearch
set wildmenu
set ruler

colorscheme peachpuff
highlight Comment ctermfg=green

map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

autocmd BufWritePre * :%s/\s\+$//e

command! W w
command! WQ wq
command! Wq wq
command! Q q

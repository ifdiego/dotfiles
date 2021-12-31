filetype plugin indent on
syntax on
set autoindent
set number
set ruler
colorscheme peachpuff
set smarttab
set hlsearch
set ignorecase
set incsearch
set smartcase
set shiftwidth=2
set expandtab
set tabstop=2
set splitbelow
set splitright
set scrolloff=8
set wildmenu

let g:python_highlight_all = 1

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWinEnter * :highlight Comment ctermfg=green

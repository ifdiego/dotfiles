call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

filetype plugin indent on
syntax on
set autoindent
set number
set ruler
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
set scrolloff=5
set hidden
set clipboard+=unnamedplus
set inccommand=split
set laststatus=0
set title
set signcolumn=number
set wildmenu

let mapleader="\<space>"
let NERDTreeShowHidden=1

highlight clear SignColumn
highlight CocInfoSign ctermfg=black ctermbg=blue
highlight CocHintSign ctermfg=black ctermbg=red

nnoremap <c-t> :NERDTreeToggle<cr>
nnoremap <c-p> :Files<cr>
nnoremap <silent> <leader>h :tabprevious<cr>
nnoremap <silent> <leader>l :tabnext<cr>
nnoremap <leader>/ :Commentary<cr>
vnoremap <leader>/ :Commentary<cr>
inoremap <silent><expr> <c-space> coc#refresh()

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufRead COMMIT_EDITMSG setlocal spell

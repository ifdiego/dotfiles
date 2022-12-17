filetype plugin indent on
syntax on
set autoindent
set number
set ruler
colorscheme default
set smarttab
set shiftwidth=2
set expandtab
set tabstop=2
set hlsearch
set ignorecase
set incsearch
set smartcase
set signcolumn=number
set hidden

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

highlight clear SignColumn
highlight Visual ctermfg=0

nnoremap <c-n> :Lexplore<cr>
nnoremap <c-t> :term ++close<cr>
nnoremap <c-l> :nohlsearch<cr>
inoremap <silent><expr> <c-space> coc#refresh()
tnoremap <c-t> <c-w>:q!<cr>
vnoremap <c-c> !xclip -f -sel clip<cr><cr>

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufRead COMMIT_EDITMSG setlocal spell

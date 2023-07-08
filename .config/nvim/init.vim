" enable filetype plugins and syntax highlighting
filetype plugin indent on
syntax on

runtime macros/matchit.vim

" settings
set autoindent
set clipboard+=unnamedplus
set completeopt=menuone,noselect
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:\|\ ,trail:.,eol:¬,nbsp:␣,extends:⋯,precedes:⋯
set number
set path+=**
set relativenumber
set ruler
set scrolloff=5
set shiftwidth=4
set showcmd
set showtabline=2
set signcolumn=number
set smartcase
set smarttab
set splitbelow
set splitright
set tabstop=4
set title
set undodir=~/.vim/undodir
set undofile
set wildmenu
set wildmode=longest,list

let mapleader = "\<space>"

nnoremap j gj
nnoremap k gk

" remap navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

noremap <silent> <c-s-left> :vertical resize +1<cr>
noremap <silent> <c-s-right> :vertical resize -1<cr>
noremap <silent> <c-s-up> :resize +1<cr>
noremap <silent> <c-s-down> :resize -1<cr>

" move line up/down:
inoremap <a-j> <esc>:m .+1<cr>==gi
inoremap <a-k> <esc>:m .-2<cr>==gi
nnoremap <a-j> :m+<cr>
nnoremap <a-k> :m--<cr>
xnoremap <a-j> :m '>+1<cr>gv
xnoremap <a-k> :m '<-2<cr>gv

"inoremap <silent><expr> <c-space> coc#refresh()
inoremap jj <esc>

" shortcuts using <leader>
nnoremap <leader>e :Lexplore<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader>n :tabnext<cr>
nnoremap <leader>p :tabprevious<cr>
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>s :setlocal spell!<cr>

" toggle bash
if has('nvim')
    set inccommand=split
    nnoremap <c-p> :split term://bash<cr>i
    nnoremap <c-t> :vsplit term://bash<cr>i
    autocmd TermOpen * setlocal nonumber statusline=%{b:term_title}
endif

if !has('nvim')
    nnoremap <c-p> :term ++close<cr>
    nnoremap <c-t> :vert term<cr>
endif

tnoremap <c-p> <c-\><c-n>:q!<cr>
tnoremap <c-t> <c-\><c-n>:q!<cr>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

colorscheme default
highlight clear SignColumn

" removing trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

autocmd BufEnter * silent! lcd %:p:h
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch
autocmd VimResized * :wincmd =

" return to last position when opening files
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee > /dev/null %

lua require('plugins')
lua require('lsp')

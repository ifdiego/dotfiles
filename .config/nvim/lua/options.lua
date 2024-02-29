vim.opt.termguicolors = true -- enable 24-bit RGB colors
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- make line numbers relative
vim.opt.wrap = false -- display long lines as just one line
vim.opt.hidden = true -- current buffer can be put into background
vim.opt.wildmode = "longest,list" -- complete files like a shell
vim.opt.updatetime = 300 -- time waiting before trigger a plugin after you stop typing
vim.opt.autowrite = true -- automatically save before :next, :make etc
vim.opt.timeoutlen = 500 -- time waiting for a sequence to complete
vim.opt.completeopt = "menuone,noinsert,noselect" -- autocomplete options
vim.opt.backup = false -- don't use backup files
vim.opt.swapfile = false -- don't use swapfiles
vim.opt.autochdir = true -- change CWD when opening a file
vim.opt.cursorline = true -- highlight current line
vim.opt.cursorlineopt = "number" -- but only the number
vim.opt.inccommand = "split" -- incrementally show result of command
vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
vim.opt.mouse = "a" -- enable mouse support in all modes
vim.opt.splitright = true -- vertical splits goes to the right
vim.opt.splitbelow = true -- horizontal splits goes below

vim.opt.autoindent = true -- automatically indent when starting a new line
vim.opt.expandtab = true -- expand tabs into spaces
vim.opt.tabstop = 4 -- number of spaces a TAB counts for
vim.opt.shiftwidth = 4 -- number of spaces to use for each step of indent
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true -- case sensitive searching if begins with uppercase

vim.opt.foldmethod = "expr" -- specify an expression to define folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for folding
vim.opt.foldenable = false -- don't fold text by default when opening files

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 25

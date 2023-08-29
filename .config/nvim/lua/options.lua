-- disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- enable 24-bit RGB colors

vim.opt.number = true        -- show line numbers
vim.opt.showmode = false     -- don't show things like -- INSERT -- anymore
vim.opt.splitright = true    -- all vertical splits goes to the right
vim.opt.splitbelow = true    -- all horizontal splits goes below
vim.opt.autowrite = true     -- automatically save before :next, :make etc
vim.opt.autochdir = true     -- change CWD when opening a file

vim.opt.mouse = "a"                -- enable mouse support in all modes
vim.opt.clipboard = "unnamedplus"  -- copy/paste to system clipboard
vim.opt.swapfile = false           -- don't use swapfiles
vim.opt.ignorecase = true          -- case insensitive searching
vim.opt.smartcase = true           -- case sensitive searching if begins with uppercase
vim.opt.completeopt = "menuone,noinsert,noselect"  -- autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- indent settings
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 4    -- number of spaces to use for each step of indent
vim.opt.tabstop = 4       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- automatically indent when starting a new line

vim.opt.hidden = true          -- current buffer can be put into background
vim.opt.backup = false         -- don't use backup files
vim.opt.scrolloff = 8          -- don't touch top/bottom except it's eof
vim.opt.relativenumber = true  -- show relative line numbers
vim.opt.pumheight = 20         -- popup menu height
vim.opt.wildmode = "longest,list"  -- complete files like a shell

--breakindent ou wrap
--updatetime, ttimeoutlen, foldmethod, foldexpr

-- this comes first, because we have mappings that depend on leader
-- with a map leader it's possible to do extra key combinations
-- i.e: <leader>w saves the current file
vim.g.mapleader = " "

-- fast saving
vim.keymap.set("n", "<leader>w", ":write!<cr>")
vim.keymap.set("n", "<leader>q", ":quit!<cr>", { silent = true })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- better split switching
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- panes resizing
vim.keymap.set("n", "<c-s-left>", ":vertical resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-right>", ":vertical resize -1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-up>", ":resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-down>", ":resize -1<cr>", { silent = true })

-- move lines up/down
vim.keymap.set("i", "<a-j>", "<esc> :move .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc> :move .-2<cr>==gi")
vim.keymap.set("n", "<a-j>", ":move+<cr>")
vim.keymap.set("n", "<a-k>", ":move--<cr>")
vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv=gv")

-- exit on jj and jk
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<esc>", "<cmd>:nohlsearch<cr>:<bs>", { silent = true })

-- shortcuts using <leader>
vim.keymap.set("n", "<leader>k", vim.cmd.WhichKey)
vim.keymap.set("n", "<leader>n", ":bnext<cr>")
vim.keymap.set("n", "<leader>p", ":bprevious<cr>")
vim.keymap.set("n", "<leader>s", ":setlocal spell!<cr>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>x", ":bdelete!<cr>")

-- toggle fish shell
vim.keymap.set("n", "<leader>j", ":split term://fish<cr>")
vim.keymap.set("n", "<leader>v", ":vsplit term://fish<cr>")
vim.keymap.set("t", "<leader>q", "<c-\\><c-n>:q!<cr>")

-- file-tree mapping
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { noremap = true })

-- diffview
vim.keymap.set("n", "<leader>do", ":DiffviewFileHistory %<cr>")
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<cr>")

-- trouble
vim.keymap.set("n", "<leader>t", function() require("trouble").open() end)

-- mappings to move out from terminal to other views
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<leader>m", vim.cmd.Mason)

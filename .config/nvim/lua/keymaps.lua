-- move by visual line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- better split switching
vim.keymap.set("n", "<c-h>", ":wincmd h<cr>")
vim.keymap.set("n", "<c-j>", ":wincmd j<cr>")
vim.keymap.set("n", "<c-k>", ":wincmd k<cr>")
vim.keymap.set("n", "<c-l>", ":wincmd l<cr>")

-- panes resizing
vim.keymap.set("n", "<c-s-left>", ":vertical resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-right>", ":vertical resize -1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-up>", ":horizontal resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-down>", ":horizontal resize -1<cr>", { silent = true })

-- move lines up/down
vim.keymap.set("i", "<a-j>", "<esc> :move .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc> :move .-2<cr>==gi")
vim.keymap.set("n", "<a-j>", ":move+<cr>")
vim.keymap.set("n", "<a-k>", ":move--<cr>")
vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv=gv")

vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", { silent = true })

-- shortcuts using <leader>
vim.keymap.set("n", "<leader>hc", vim.cmd.DiffviewClose)
vim.keymap.set("n", "<leader>hh", vim.cmd.DiffviewFileHistory)
vim.keymap.set("n", "<leader>ho", vim.cmd.DiffviewOpen)
vim.keymap.set("n", "<leader>i", vim.cmd.InspectTree)
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)
vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>p", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>t", vim.cmd.TroubleToggle)
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete)

-- remain in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- avoid the worst place in the universe
vim.keymap.set("n", "q", "<nop>")

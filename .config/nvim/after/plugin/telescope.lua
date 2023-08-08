local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- don't go to insert mode
        ["<c-j>"] = actions.cycle_history_next, -- cycle through next in history
        ["<c-k>"] = actions.cycle_history_prev, -- cycle throught previous in history
      }
    }
  },
}

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fc", builtin.git_files, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>f", "<cmd>Telescope<cr>", {})

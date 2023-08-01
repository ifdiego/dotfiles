local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- don't go to insert mode
      }
    }
  },
}

vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<leader>c", builtin.git_files, {})
vim.keymap.set("n", "<leader>y", builtin.help_tags, {})
vim.keymap.set("n", "<leader>T", "<cmd>Telescope<cr>", {})

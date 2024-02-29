return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    require("telescope").setup {
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules" },
        mappings = {
          i = {
            ["<esc>"] = actions.close, -- don't go to insert mode
            ["<c-j>"] = actions.cycle_history_next, -- cycle through next in history
            ["<c-k>"] = actions.cycle_history_prev, -- cycle through previous in history
          },
        },
        extensions = {
          fzf = {},
          undo = {
            saved_only = true,
          },
          live_grep_args = {},
          file_browser = {},
        },
      },
    }

    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", {})
    vim.keymap.set("n", "<leader>fi", builtin.git_files, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
    vim.keymap.set("n", "<leader>fn", builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
    vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", {})
    vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", {})
    vim.keymap.set("n", "<leader>f", vim.cmd.Telescope, {})

    -- to get extensions loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("file_browser")
  end,
}

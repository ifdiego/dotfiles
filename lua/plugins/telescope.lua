return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  lazy = false,
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<cr>", desc = "Search Files" },
    { "<leader>fb", ":Telescope buffers<cr>", desc = "Find existing buffers" },
    { "<leader>fh", ":Telescope help_tags<cr>", desc = "Search Help" },
    { "<leader>fo", ":Telescope oldfiles<cr>", desc = "Find recently opened files" },
    { "<leader>fw", ":Telescope grep_string<cr>", desc = "Search Current Word" },
    { "<leader>fg", ":Telescope live_grep<cr>", desc = "Search by Grep" },
    { "<leader>fs", ":Telescope diagnostics<cr>", desc = "Search Diagnostics" },
    { "<leader>fi", ":Telescope git_files<cr>", desc = "Search Git Files" },
    { "<leader>fk", ":Telescope keymaps<cr>", desc = "Search Keymaps" },
  },
  config = function()
    local builtin = require "telescope.builtin"

    require("telescope").setup {
      extensions = {
        fzf = {},
        undo = { saved_only = true },
        live_grep_args = {},
        file_browser = {},
      },
    }

    vim.keymap.set("n", "<leader>fu", function()
      require("telescope").extensions.undo.undo()
    end)

    vim.keymap.set("n", "<leader>fe", function()
      require("telescope").extensions.file_browser.file_browser()
    end)

    -- to get extensions loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "undo"
    require("telescope").load_extension "file_browser"
  end
}

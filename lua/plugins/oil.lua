return {
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Toggle file explorer" },
  },
  opts = {
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  },
  lazy = false,
}


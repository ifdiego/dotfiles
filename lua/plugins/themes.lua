return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
    end,
  },

  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
    end,
  },

  {
    "blazkowolf/gruber-darker.nvim",
    opts = {
      italic = {
        strings = false,
        comments = false,
      },
    },
  },

  {
    "p00f/alabaster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
    },
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup{}
      vim.cmd.colorscheme "github_dark_default"
      vim.cmd.highlight "StatusLine guifg=white guibg=none"
    end,
  }
}

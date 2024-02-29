return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "javascript",
        "json",
        "lua",
        "python",
        "query",
        "rust",
        "typescript",
        "zig",
      },
      highlight = {
        enable = true, -- false will disable the whole extension
      },
      indent = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- you can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]a"] = "@parameter.outer",
            ["]c"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
            ["]A"] = "@parameter.outer",
            ["]C"] = "@conditional.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[]"] = "@class.outer",
            ["[a"] = "@parameter.outer",
            ["[c"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[A"] = "@parameter.outer",
            ["[C"] = "@conditional.outer",
            ["[L"] = "@loop.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    }
  end,
}

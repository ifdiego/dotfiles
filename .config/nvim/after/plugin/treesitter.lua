require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "fish",
    "go",
    "gomod",
    "javascript",
    "lua",
    "python",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<space>", -- maps in normal mode to init the node/scope selection with space
      node_incremental = "<space>", -- increment to the upper named parent
      node_decremental = "<bs>", -- decrement to the previous node
      scope_incremental = "<tab>", -- increment to the upper scope (as defined in locals.scm)
    },
  },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,

    -- Disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

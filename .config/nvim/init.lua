vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    { "neovim/nvim-lspconfig" },
    { "ibhagwan/fzf-lua" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "saghen/blink.cmp", dependencies = { "rafamadriz/friendly-snippets" }, version = "*" },
    { "NeogitOrg/neogit", dependencies = { "nvim-lua/plenary.nvim" } },
    { "stevearc/conform.nvim" },
    { "echasnovski/mini.nvim" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true

local fzf = require "fzf-lua"
fzf.setup { "ivy", keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } } }
vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fg", fzf.live_grep)
vim.keymap.set("n", "<leader>fb", fzf.buffers)
vim.keymap.set("n", "<leader>fd", fzf.lsp_document_diagnostics)

vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<leader>e", vim.cmd.Explore)

vim.keymap.set("v", "J", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<cr>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>w", ":write<cr>")
vim.keymap.set("n", "<leader>q", ":quit<cr>")
vim.keymap.set("n", "<leader>x", ":bdelete<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.cmd.colorscheme "default"
vim.cmd.highlight "StatusLine guifg=NvimLightGrey3 guibg=NvimDarkGrey1"

local lspconfig = require("lspconfig")
-- lspconfig.clangd.setup {}
lspconfig.gopls.setup {}
-- lspconfig.lua_ls.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {},
  },
}
lspconfig.ts_ls.setup {}
lspconfig.zls.setup {}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    -- vim.keymap.set("n", "<space>f", vim.lsp.buf.format)
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
})

vim.diagnostic.config { virtual_text = true }

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono"
  },
  cmdline = { enabled = false },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true },
  fuzzy = { implementation = "prefer_rust_with_warning" },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "go", "rust", "typescript", "zig" },
  highlight = {
    enable = true,
  },
}

require("conform").setup {
  formatters_by_ft = {
    go = { "gofmt" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

local neogit = require "neogit"
neogit.setup {}
vim.keymap.set("n", "<leader>gg", neogit.open)

require("mini.pairs").setup {}
require("mini.splitjoin").setup {}
require("mini.surround").setup {}

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

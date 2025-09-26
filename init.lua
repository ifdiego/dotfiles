-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { "neovim/nvim-lspconfig" },
    { "ibhagwan/fzf-lua" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "saghen/blink.cmp", version = "*" },
    { "lewis6991/gitsigns.nvim" },
    { "NeogitOrg/neogit", dependencies = { "nvim-lua/plenary.nvim" } },
    { "stevearc/conform.nvim" },
    { "echasnovski/mini.nvim" },
    -- { "stevearc/oil.nvim" },
    { "j-hui/fidget.nvim" },
    { "ruifm/gitlinker.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "mbbill/undotree" },
    { "wakatime/vim-wakatime", lazy = false },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- faster startup
vim.loader.enable()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 4
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.jumpoptions = "stack,view"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "data" .. "undo"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

vim.g.mapleader = " "
vim.keymap.set("n", "<space>", "<nop>")

-- files
vim.keymap.set("n", "<leader>e", vim.cmd.Explore)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- move lines up/down
vim.keymap.set("v", "J", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<cr>gv=gv")

-- join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor centered
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>w", ":write<cr>")
vim.keymap.set("n", "<leader>qq", ":quit<cr>")

-- buffers
vim.keymap.set("n", "<leader>n", ":bnext<cr>")
vim.keymap.set("n", "<leader>p", ":bprevious<cr>")
vim.keymap.set("n", "<leader>x", ":bdelete<cr>")

-- resizing panes
vim.keymap.set("n", "<left>", ":vertical resize +1<cr>")
vim.keymap.set("n", "<right>", ":vertical resize -1<cr>")
vim.keymap.set("n", "<up>", ":resize +1<cr>")
vim.keymap.set("n", "<down>", ":resize -1<cr>")

-- quickfix
vim.keymap.set("n", "]q", ":cnext<cr>zz")
vim.keymap.set("n", "[q", ":cprevious<cr>zz")

-- lsp
vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<space>f", vim.lsp.buf.format)

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.cmd.colorscheme "default"
vim.cmd.highlight "StatusLine guifg=NvimLightGrey3 guibg=NvimDarkGrey1"

local fzf = require "fzf-lua"
fzf.setup { "ivy", keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } } }
vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fg", fzf.live_grep)
vim.keymap.set("n", "<leader>fb", fzf.buffers)
vim.keymap.set("n", "<leader>gf", fzf.git_files)
vim.keymap.set("n", "<leader>gl", fzf.git_commits)
vim.keymap.set("n", "<leader>fd", fzf.lsp_document_diagnostics)
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols)

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

vim.diagnostic.config { virtual_text = false }
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

require("fidget").setup {}

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono"
  },
  cmdline = { enabled = false },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 250 },
    menu = {
      draw = {
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" }
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "go", "rust", "typescript", "zig" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
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

require("gitsigns").setup {}
require("gitlinker").setup {}

local neogit = require "neogit"
neogit.setup {}
vim.keymap.set("n", "<leader>gg", neogit.open)

require("mini.pairs").setup {}
require("mini.splitjoin").setup {}
require("mini.surround").setup {}

-- require("oil").setup { view_options = { show_hidden = true } }

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

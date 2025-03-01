vim.loader.enable()

-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { "neovim/nvim-lspconfig" },
    { "ibhagwan/fzf-lua" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "saghen/blink.cmp", version = "*" },
    { "lewis6991/gitsigns.nvim" },
    { "stevearc/conform.nvim" },
    { "echasnovski/mini.nvim" },
    { "stevearc/oil.nvim" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- display line numbers relative
vim.opt.splitbelow = true -- horizontal splits goes below
vim.opt.splitright = true -- vertical splits goes to the right
vim.opt.wrap = false -- display long lines as just one line
vim.opt.expandtab = true -- convert tabs into spaces
vim.opt.tabstop = 4 -- number of spaces a TAB counts for
vim.opt.shiftwidth = 4 -- number of spaces to use for each step of indent
vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
vim.opt.scrolloff = 4 -- don't touch top/bottom except its EOF
vim.opt.virtualedit = "block" -- enable highlighting empty spaces
vim.opt.inccommand = "split" -- show preview of substitution
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true -- unless uppercase in search term
vim.opt.completeopt = "menuone,noinsert,noselect" -- autocomplete options
vim.opt.jumpoptions = "stack,view" -- keep jump history and restore buffer view
vim.opt.laststatus = 3 -- global statusline
vim.opt.wildmode = "longest:list,full" -- complete files like a shell
vim.opt.undofile = true -- save undo history
vim.opt.undodir = vim.fn.stdpath "data" .. "undo"

vim.keymap.set("n", "<space>", "<nop>")

-- buffers
vim.keymap.set("n", "<leader>n", ":bnext<cr>")
vim.keymap.set("n", "<leader>p", ":bprevious<cr>")
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>x", ":bdelete<cr>")

-- files
vim.keymap.set("n", "<leader>ff", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "-", ":Oil<cr>")

-- move lines up/down
vim.keymap.set("v", "J", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<cr>gv=gv")

-- keep cursor centered
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- resizing panes
vim.keymap.set("n", "<left>", ":vertical resize +1<cr>")
vim.keymap.set("n", "<right>", ":vertical resize -1<cr>")
vim.keymap.set("n", "<up>", ":resize +1<cr>")
vim.keymap.set("n", "<down>", ":resize -1<cr>")

-- quickfix
vim.keymap.set("n", "]q", ":cnext<cr>zz")
vim.keymap.set("n", "[q", ":cprevious<cr>zz")

-- git
vim.keymap.set("n", "<leader>gl", ":FzfLua git_commits<cr>")

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
vim.keymap.set("n", "<leader>fd", ":FzfLua lsp_document_diagnostics<cr>")
vim.keymap.set("n", "<leader>fs", ":FzfLua lsp_document_symbols<cr>")

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

require("fzf-lua").setup { keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } } }

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

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono"
  },
  cmdline = { enabled = false },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 250 },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true },
}

require("mini.pairs").setup {}
require("mini.splitjoin").setup {}
require("mini.surround").setup {}

require("oil").setup { view_options = { show_hidden = true } }

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
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

vim.cmd.colorscheme "default"

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

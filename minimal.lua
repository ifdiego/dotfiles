vim.loader.enable()

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- line info
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

-- indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- aesthetic
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.winborder = "rounded"

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore case in search, unless starts with upper case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- undo history
vim.opt.undofile = true

vim.g.mapleader = " "

-- keybinds
vim.keymap.set("n", "<space>", "<nop>")

vim.keymap.set("n", "<leader>w", ":write<cr>")
vim.keymap.set("n", "<leader>q", ":quitall<cr>")

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

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.cmd.colorscheme "default"
--vim.cmd.highlight "StatusLine guifg=NvimLightGrey3 guibg=NvimDarkGrey1"

-- setup lazy.nvim
require "lazy".setup({
  spec = {
    { "ibhagwan/fzf-lua" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "echasnovski/mini.nvim" },
    { "stevearc/oil.nvim" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require "fzf-lua".setup { "ivy" }
vim.keymap.set("n", "<leader>ff", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<cr>")

require "mini.pairs".setup {}
require "mini.splitjoin".setup {}
require "mini.surround".setup {}

require "oil".setup {}
vim.keymap.set("n", "-", ":Oil<cr>")

vim.lsp.config["gopls"] = {
  cmd = { "gopls" },
  root_markers = { "go.mod", "go.work" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" }
}

vim.lsp.config["rust-analyzer"] = {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.toml" },
  filetypes = { "rust" }
}

vim.lsp.config["ts_ls"] = {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "package.json", "tsconfig.json" },
  filetypes = { "javascript", "typescript" }
}

vim.lsp.config["zls"] = {
  cmd = { "zls" },
  root_markers = { "build.zig" },
  filetypes = { "zig" }
}

vim.lsp.enable("gopls")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("zls")

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

    vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)

    -- auto-format ("lint") on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
      end,
    })

    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
})

vim.opt.completeopt = "menuone,popup,noselect,fuzzy"

-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function()
  vim.lsp.completion.get()
end)

require "nvim-treesitter.configs".setup {
  highlight = { enable = true },
  indent = { enable = true },
}

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

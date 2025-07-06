vim.loader.enable()

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- setup lazy.nvim
require "lazy".setup({
  spec = {
    -- fuzzy finder
    {
      "ibhagwan/fzf-lua",
      config = function()
        require "fzf-lua".setup { "ivy" }
        vim.keymap.set("n", "<leader>ff", ":FzfLua files<cr>")
        vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<cr>")
        vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<cr>")
      end,
    },
    -- syntax highlight
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = { "go", "rust", "typescript", "zig" },
          highlight = { enable = true },
          indent = { enable = true }
        }
      end,
    },
    -- mini plugins
    {
      "echasnovski/mini.nvim",
      config = function()
        require "mini.splitjoin".setup {}
        require "mini.surround".setup {}
      end,
    },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- line info
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

-- indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- aesthetic
vim.cmd.colorscheme "default"
vim.o.winborder = "rounded"

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore case in search, unless starts with upper case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- undo history
vim.opt.undofile = true

-- keybinds
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<leader>e", vim.cmd.Explore)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>q", vim.cmd.quitall)
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist)

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

-- language servers
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

vim.diagnostic.config { virtual_text = true }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- enable completion when available
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)

    -- auto-format ("lint") on save
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
})

vim.opt.completeopt = "menuone,popup,noselect,fuzzy"
-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function()
  vim.lsp.completion.get()
end)

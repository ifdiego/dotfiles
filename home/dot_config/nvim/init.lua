vim.loader.enable()

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
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

-- resizing panes
vim.keymap.set("n", "<left>", ":vertical resize +1<cr>")
vim.keymap.set("n", "<right>", ":vertical resize -1<cr>")
vim.keymap.set("n", "<up>", ":resize +1<cr>")
vim.keymap.set("n", "<down>", ":resize -1<cr>")

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  -- { src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
})

require "fzf-lua".setup { "ivy" }
vim.keymap.set("n", "<leader>ff", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<cr>")

require "gitsigns".setup {}

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

vim.lsp.enable("gopls")

 vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)

    -- auto-format ("lint") on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
      end,
    })
  end,
})

vim.diagnostic.config { virtual_text = true, virtual_lines = false }
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

vim.opt.completeopt = "menuone,popup,noselect,fuzzy"

-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function()
  vim.lsp.completion.get()
end)

require "nvim-treesitter.configs".setup {
  ensure_installed = { "go", "gopls" },
  highlight = { enable = true },
  indent = { enable = true },
}

vim.cmd.colorscheme "default"
--vim.cmd.highlight "StatusLine guifg=NvimLightGrey3 guibg=NvimDarkGrey1"

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

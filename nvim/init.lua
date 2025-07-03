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
    -- language servers
    {
      "neovim/nvim-lspconfig",
      config = function()
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
      end,
    },
    -- fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require "telescope".setup {}

        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
      end,
    },
    -- syntax highlight
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = { "go", "rust", "typescript", "zig" },
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          }
        }
      end,
    },
    -- autocomplete
    {
      "Saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      config = function()
        require "blink.cmp".setup {
          keymap = { preset = "default" },
          appearance = {
            nerd_font_variant = "mono"
          },
          completion = { documentation = { auto_show = true } },
          signature = { enabled = true },
          -- cmdline = { enabled = false },
          sources = {
            default = { "lsp", "path", "snippets", "buffer" },
          },
          fuzzy = { implementation = "prefer_rust_with_warning" }
        }
      end,
    },
    -- git
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require "gitsigns".setup {}
      end,
    },
    -- neovim's magit
    {
      "NeogitOrg/neogit",
      config = function()
        require "neogit".setup {}
        vim.keymap.set("n", "<leader>gg", ":Neogit kind=replace<cr>", { desc = "Neogit" })
      end,
    },
    -- quickfix
    {
      "folke/trouble.nvim",
      config = function()
        require "trouble".setup {}
        vim.keymap.set("n", "<leader>d", ":Trouble diagnostics toggle<cr>", { desc = "Quickfix" })
      end,
    },
    -- help shortcuts
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        require "which-key".setup {}
      end,
    },
    -- mini plugins
    {
      "echasnovski/mini.nvim",
      config = function()
        require "mini.splitjoin".setup {}
        require "mini.surround".setup {}

        local statusline = require "mini.statusline"
        statusline.setup { use_icons = true }

        statusline.section_location = function()
          return "%2l:%-2v"
        end
      end,
    },
    -- file explorer
    {
      "stevearc/oil.nvim",
      config = function()
        require "oil".setup {
          columns = {
            "icon",
            "size",
            "mtime",
          },
          delete_to_trash = true,
          skip_confirm_for_simple_edits = true,
          -- prompt_save_on_select_new_entry = true,
          keymaps = {
            ["<cr>"] = "actions.select",
            ["q"] = { "actions.close", mode = "n" },
          },
          view_options = {
            show_hidden = true,
          },
        }
        vim.keymap.set("n", "-", ":Oil<cr>", { desc = "File explorer" })
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
-- vim.opt.cursorline = true

-- indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- aesthetic
vim.cmd.colorscheme "default"
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
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
-- vim.keymap.set("n", "<leader>e", ":Explore<cr>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>w", ":write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":quitall<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", ":bdelete<cr>", { desc = "Close buffer" })
-- vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { desc = "Send quickfix" })

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

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- enable completion when available
    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    -- end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { desc = "Goto type definition" })

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

-- -- see `:h completeopt`
-- vim.opt.completeopt = "menuone,popup,noselect,fuzzy"
-- -- map <c-space> to activate completion
-- vim.keymap.set("i", "<c-space>", function()
--   vim.lsp.completion.get()
-- end)

-- disable comment on new line
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt.formatoptions:remove { "c", "r", "o" }
	end,
})

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

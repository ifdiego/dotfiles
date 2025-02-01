vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

require("lazy").setup({
  spec = {
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("lspconfig").clangd.setup {}
        require("lspconfig").gopls.setup {}
        require("lspconfig").lua_ls.setup {}
        require("lspconfig").rust_analyzer.setup {}
        require("lspconfig").ts_ls.setup {}
        require("lspconfig").zls.setup {}

        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

        vim.diagnostic.config {
          float = {
            border = "rounded",
          },
        }
      end,
    },

    {
      "ibhagwan/fzf-lua",
      opts = {
        winopts = {
          split = "belowright 20new"
        },
        keymap = {
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          }
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "c", "go", "gomod", "lua", "rust", "typescript", "vim", "vimdoc" },
          highlight = {
            enable = true,
            disable = function(lang, buf)
              local max_filesize = 100 * 1024
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
          },
        }
      end,
    },

    {
      "saghen/blink.cmp",
      version = "*",
      opts = {
        keymap = { preset = "default" },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono"
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          cmdline = {},
        },
        signature = { enabled = true },
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            window = {
              border = "rounded",
            },
          },
        },
      },
    },

    {
      "j-hui/fidget.nvim",
      opts = {},
    },

    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      },
    },

    {
      "echasnovski/mini.nvim",
      config = function()
        local statusline = require "mini.statusline"
        statusline.setup { use_icons = true }

        statusline.section_location = function()
          return "%2l:%-2v"
        end
      end,
    },

    {
      "stevearc/oil.nvim",
      opts = {
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
        },
        view_options = {
          show_hidden = true,
        },
      },
      lazy = false,
    },

  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.jumpoptions = "stack,view"
vim.opt.laststatus = 3
vim.opt.wildmode = "longest:list,full"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "data" .. "undo"

vim.keymap.set("v", "J", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<cr>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<m-j>", ":cnext<cr>zz")
vim.keymap.set("n", "<m-k>", ":cprevious<cr>zz")
vim.keymap.set("n", "<leader>y", "yy :normal gcc<cr>p")
vim.keymap.set("v", "<leader>y", ":copy '><cr>:'<,'>normal ^i-- <cr>")
vim.keymap.set("n", "<leader>ff", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>fh", ":FzfLua helptags<cr>")
vim.keymap.set("n", "<leader>fd", ":FzfLua lsp_document_diagnostics<cr>")
vim.keymap.set("n", "gb", ":Gitsigns toggle_current_line_blame<cr>")
vim.keymap.set("n", "-", ":Oil<cr>")
vim.keymap.set("n", "U", "<c-r>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.cmd.colorscheme "default"
vim.cmd.highlight "StatusLine guifg=NvimLightGrey3 guibg=NvimDarkGrey1"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

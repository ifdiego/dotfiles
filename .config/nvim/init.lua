local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

require("lazy").setup({
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = {
          "clangd",
          "gopls",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "tsserver",
          "zls"
        },
      }

      local lspconfig = require("lspconfig")

      -- use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- see `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist)

        -- see `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>ge", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>go", vim.lsp.buf.document_symbol, opts)
        vim.keymap.set("n", "<leader>gw", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>gt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>gf", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require "lspconfig/util"

      lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      }

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              -- get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
        },
      }

      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "rust" },
        root_dir = util.root_pattern("Cargo.toml"),
        settings = {
          ["rust_analyzer"] = {
            completion = {
              postfix = {
                enable = false,
              },
            },
            cargo = {
              features = "all",
              allFeatures = true,
            },
          },
        },
      }

      lspconfig.tsserver.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.zls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          zls = {
            enable_inlay_hints = true,
            inlay_hints_show_builtin = true,
            include_at_in_builtins = true,
            warn_style = true,
          },
        },
      }

      vim.diagnostic.config({
        update_in_insert = true,
      })

      require("trouble").setup {
        icons = false,
      }

      require("fidget").setup {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup {}

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = 'nvim_lsp_signature_help' },
        }),
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
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
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules" },
          mappings = {
            i = {
              ["<esc>"] = actions.close, -- don't go to insert mode
              ["<c-j>"] = actions.cycle_history_next, -- cycle through next in history
              ["<c-k>"] = actions.cycle_history_prev, -- cycle through previous in history
            },
          },
          extensions = {
            fzf = {},
            undo = {
              saved_only = true,
            },
            live_grep_args = {},
            file_browser = {},
          },
        },
      }

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", {})
      vim.keymap.set("n", "<leader>fi", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>fn", builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
      vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", {})
      vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", {})
      vim.keymap.set("n", "<leader>f", vim.cmd.Telescope, {})

      -- to get extensions loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup {
        use_icons = false,
      }
    end,
  },
  {
    "blazkowolf/gruber-darker.nvim",
    opts = {
      italic = {
        strings = false,
        comments = false,
      },
    },
    config = function()
      -- vim.cmd.colorscheme "gruber-darker"
    end,
  },
  {
    "p00f/alabaster.nvim",
    config = function()
      vim.cmd.colorscheme "alabaster"
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
  },
})

vim.opt.termguicolors = true -- enable 24-bit RGB colors

vim.opt.number = true        -- show line numbers
vim.opt.relativenumber = true  -- make line numbers relative
vim.opt.splitright = true    -- vertical splits goes to the right
vim.opt.splitbelow = true    -- horizontal splits goes below
vim.opt.autowrite = true     -- automatically save before :next, :make etc
vim.opt.autochdir = true     -- change CWD when opening a file

vim.opt.mouse = "a"                -- enable mouse support in all modes
vim.opt.clipboard = "unnamedplus"  -- copy/paste to system clipboard
vim.opt.swapfile = false           -- don't use swapfiles
vim.opt.ignorecase = true          -- case insensitive searching
vim.opt.smartcase = true           -- case sensitive searching if begins with uppercase
vim.opt.completeopt = "menuone,noinsert,noselect"  -- autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 4    -- number of spaces to use for each step of indent
vim.opt.tabstop = 4       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- automatically indent when starting a new line
vim.opt.wrap = false      -- display long lines as just one line

vim.opt.hidden = true          -- current buffer can be put into background
vim.opt.backup = false         -- don't use backup files
vim.opt.inccommand = "split"   -- incrementally show result of command
vim.opt.cursorline = true      -- highlight current line
vim.opt.cursorlineopt = "number"   -- but only the number
vim.opt.wildmode = "longest,list"  -- complete files like a shell

vim.opt.timeoutlen = 500           -- time waiting for a sequence to complete
vim.opt.updatetime = 300           -- time waiting before trigger a plugin after you stop typing
vim.opt.foldmethod = "expr"        -- specify an expression to define folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- use treesitter for folding
vim.opt.foldenable = false         -- don't fold text by default when opening files

-- fast saving
vim.keymap.set("n", "<leader>w", ":write!<cr>")
vim.keymap.set("n", "<leader>q", ":quit!<cr>", { silent = true })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- better split switching
vim.keymap.set("n", "<c-h>", ":wincmd h<cr>")
vim.keymap.set("n", "<c-j>", ":wincmd j<cr>")
vim.keymap.set("n", "<c-k>", ":wincmd k<cr>")
vim.keymap.set("n", "<c-l>", ":wincmd l<cr>")

-- panes resizing
vim.keymap.set("n", "<c-s-left>", ":vertical resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-right>", ":vertical resize -1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-up>", ":horizontal resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-down>", ":horizontal resize -1<cr>", { silent = true })

-- move lines up/down
vim.keymap.set("i", "<a-j>", "<esc> :move .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc> :move .-2<cr>==gi")
vim.keymap.set("n", "<a-j>", ":move+<cr>")
vim.keymap.set("n", "<a-k>", ":move--<cr>")
vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv=gv")

vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", { silent = true })

-- shortcuts using <leader>
vim.keymap.set("n", "<leader>hc", vim.cmd.DiffviewClose)
vim.keymap.set("n", "<leader>hh", vim.cmd.DiffviewFileHistory)
vim.keymap.set("n", "<leader>ho", vim.cmd.DiffviewOpen)
vim.keymap.set("n", "<leader>i", vim.cmd.InspectTree)
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)
vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>p", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>t", vim.cmd.TroubleToggle)
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete)

-- remain in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- avoid the worst place in the universe
vim.keymap.set("n", "q", "<nop>")

-- removing trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- don't auto comment new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

vim.api.nvim_command("autocmd InsertEnter * setlocal nohlsearch")
vim.api.nvim_command("autocmd InsertLeave * setlocal hlsearch")

-- automatically resize vim buffers
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- return to last position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.fn.setpos(".", vim.fn.getpos("'\""))
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank{ timeout = 200, visual = true }
  end,
})

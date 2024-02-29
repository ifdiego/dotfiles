return {
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
      fold_open = "v", -- icon used for open folds
      fold_closed = ">", -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }

    require("fidget").setup {}
  end,
}

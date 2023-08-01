local lspconfig = require("lspconfig")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>b", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>a", vim.diagnostic.goto_next)
--vim.keymap.set("n", "<space>f", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>de", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
    --vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, opts)
    --vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set("n", "<space>wl", function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    --vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    --vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    --vim.keymap.set("n", "<space>f", function()
    --  vim.lsp.buf.format { async = true }
    --end, opts)
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require "lspconfig/util"

lspconfig.tsserver.setup {
  capabilities = capabilities
}

lspconfig.pyright.setup {
  capabilities = capabilities
}

lspconfig.gopls.setup {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  capabilities = capabilities
}

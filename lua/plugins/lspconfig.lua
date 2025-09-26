return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    -- use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- see `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
        vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format { async = true }
        end)

        -- auto-format ("lint") on save
        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end

        -- enable inlay hints
        -- https://neovim.io/doc/user/lsp.html#lsp-inlay_hint
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
    })

    vim.lsp.enable("gopls")
    vim.lsp.enable("rust-analyzer")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("zls")

    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false
    }
  end
}

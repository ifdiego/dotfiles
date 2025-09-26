return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    -- use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.server_capabilities.completionProvider then
          vim.bo[bufnr].omnifunc = "v.lua.vim.lsp.omnifunc"
        end

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

        -- enable inlay hints
        -- https://neovim.io/doc/user/lsp.html#lsp-inlay_hint
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        vim.keymap.set("n", "<leader>h", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end)

        -- none of this semantics tokens business
        -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    vim.diagnostic.config {
      update_in_insert = true,
    }
  end
}

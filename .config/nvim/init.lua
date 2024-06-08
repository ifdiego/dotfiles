-- set the leader key
vim.g.mapleader = ","

-- install package manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    -- import = "plugins",
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            {
                "folke/trouble.nvim",
                opts = { focus = true },
                keys = {
                    { "<leader>t", "<cmd>Trouble diagnostics<cr>" },
                },
            },
            "stevearc/conform.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "debugloop/telescope-undo.nvim",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
    },
    {
        "p00f/alabaster.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "alabaster"
        end,
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
            current_line_blame = true,
        },
    },
    { "kylechui/nvim-surround", opts = {} },
    "wakatime/vim-wakatime",
}

-- settings
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- display line numbers relative
vim.opt.splitright = true -- vertical splits goes to the right
vim.opt.splitbelow = true -- horizontal splits goes below
vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
vim.opt.ignorecase = true -- case insensitive search/replace
vim.opt.smartcase = true -- unless uppercase in search term
vim.opt.expandtab = true -- expand tabs into spaces
vim.opt.shiftwidth = 4 -- number of space to use for each step of indent
vim.opt.tabstop = 4 -- number of spaces a TAB counts for
vim.opt.wrap = false -- display long lines as just one line
vim.opt.inccommand = "split" -- incrementally show result of command
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- time waiting for a sequence to complete
vim.opt.foldmethod = "expr" -- specify an expression to define folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for folding
vim.opt.foldenable = false -- don't fold text by default when opening files
vim.opt.undofile = true -- save undo history
vim.opt.undodir = vim.fn.stdpath "data" .. "undo"

-- fast saving
vim.keymap.set("n", "<leader>w", ":write<cr>")
vim.keymap.set({ "i", "v" }, "<c-j>", "<esc>")

-- move lines up/down
vim.keymap.set("i", "<a-j>", "<esc> :move .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc> :move .-2<cr>==gi")
vim.keymap.set("n", "<a-j>", ":move+<cr>")
vim.keymap.set("n", "<a-k>", ":move--<cr>")
vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv=gv")

vim.keymap.set("n", "<esc>", ":nohlsearch<cr>", { silent = true })

-- cycle through buffers and quickfix list
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<s-tab>", vim.cmd.bprevious)
vim.keymap.set("n", "cn", vim.cmd.cnext)
vim.keymap.set("n", "cp", vim.cmd.cprevious)

vim.keymap.set("n", "<c-space>", vim.cmd.bdelete)

vim.keymap.set("n", "<leader>ef", vim.cmd.Ex)
vim.keymap.set("n", "U", "<c-r>")

-- keep the cursor centered on screen
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- LSP configuration and plugins
local lspconfig = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

require("mason").setup {}
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "pyright", "tsserver" },
}

lspconfig.clangd.setup {
    capabilities = capabilities,
}

lspconfig.gopls.setup {
    capabilities = capabilities,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
            },
        },
    },
}

lspconfig.pyright.setup {
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ["rust_analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                features = "all",
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    },
}

lspconfig.tsserver.setup {
    capabilities = capabilities,
}

lspconfig.zls.setup {
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

require("conform").setup {
    formatters_by_ft = {
        cpp = { "clang_format" },
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        zig = { "zigfmt" },
    },
    format_on_save = {
        lsp_fallback = true,
    },
}

-- autocomplete
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

local cmp = require "cmp"
local luasnip = require "luasnip"

luasnip.config.setup {}
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<c-y>"] = cmp.mapping.confirm { select = true },
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
    },
}

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- fuzzy finder (files, lsp, etc)
local builtin = require "telescope.builtin"

require("telescope").setup {
    extensions = {
        fzf = {},
        undo = { saved_only = true },
        live_grep_args = {},
        file_browser = {},
    },
}

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fi", builtin.git_files)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
vim.keymap.set("n", "<leader>fw", builtin.grep_string)
vim.keymap.set("n", "<leader>fn", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fk", builtin.keymaps)
vim.keymap.set("n", "<leader>f", builtin.builtin)

vim.keymap.set("n", "<leader>fg", function()
    require("telescope").extensions.live_grep_args.live_grep_args()
end)

vim.keymap.set("n", "<leader>fu", function()
    require("telescope").extensions.undo.undo()
end)

vim.keymap.set("n", "<leader>fe", function()
    require("telescope").extensions.file_browser.file_browser()
end)

-- to get extensions loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "fzf"
require("telescope").load_extension "undo"
require("telescope").load_extension "live_grep_args"
require("telescope").load_extension "file_browser"

-- highlight, edit, and navigate code
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "cpp", "go", "javascript", "lua", "python", "rust", "typescript" },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
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
                ["]c"] = "@conditional.outer",
                ["]l"] = "@loop.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@conditional.outer",
                ["]L"] = "@loop.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@conditional.outer",
                ["[l"] = "@loop.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
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

-- return to last edit position on opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        vim.fn.setpos(".", vim.fn.getpos "'\"")
    end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- in general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD leader.
-- see `:help mapleader`
vim.g.mapleader = ","

-- set loaded_matchparen here to `1` to disable parenthesis highlighting
vim.g.loaded_matchparen = 1

-- install package manager
-- `:help lazy.nvim.txt` for more info
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

require("lazy").setup({
  -- lsp configuration & plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- useful status updates for lsp
      -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
  },
  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- adds lsp completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- snippet engine & its associated nvim-cmp source
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      -- adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
  },
  -- telescope
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
  },
  -- git related plugins
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- see `:help gitsigns.txt`
      -- signs = {
      --   add = { text = "+" },
      --   change = { text = "~" },
      --   delete = { text = "_" },
      --   topdelete = { text = "‾" },
      --   changedelete = { text = "~" },
      -- },
    },
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      use_icons = false,
    },
  },
  -- colorschemes
  "blazkowolf/gruber-darker.nvim",
  "p00f/alabaster.nvim",
  { "windwp/nvim-autopairs", opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
  "folke/trouble.nvim",
  "wakatime/vim-wakatime",
  -- multi-cursor
  "mg979/vim-visual-multi",
  "rust-lang/rust.vim",
})

-- settings
-- see `:help vim.o`

-- disable netrw at the very start of init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
vim.opt.scrolloff = 5   -- don't touch top/bottom except its EOF
vim.opt.autoindent = true -- automatically indent when starting a new line
vim.opt.wrap = false      -- display long lines as just one line

vim.opt.hidden = true          -- current buffer can be put into background
vim.opt.backup = false         -- don't use backup files
vim.opt.listchars = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮"  -- strings for list mode
vim.opt.list = false           -- don't show string above by default
vim.opt.pumheight = 5          -- popup menu height
vim.opt.wildmode = "longest,list"  -- complete files like a shell

vim.opt.laststatus = 3             -- global statusline
vim.opt.timeoutlen = 500           -- by default timeoutlen is 1000ms
vim.opt.updatetime = 300           -- faster completion
vim.opt.foldmethod = "expr"        -- define fold method
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- use treesitter for folding
vim.opt.foldenable = false         -- don't fold text by default when opening files

vim.opt.cursorline = true          -- highlight the current line
vim.opt.cursorlineopt = "number"   -- but only the humbers

vim.cmd.colorscheme "alabaster"

-- keymaps for better default experience
-- see `:help vim.keymap.set()`

-- fast saving
vim.keymap.set("n", "<leader>w", ":write!<cr>")
vim.keymap.set("n", "<leader>q", ":quit!<cr>", { silent = true })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- better split switching
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- panes resizing
vim.keymap.set("n", "<c-s-left>", ":vertical resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-right>", ":vertical resize -1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-up>", ":resize +1<cr>", { silent = true })
vim.keymap.set("n", "<c-s-down>", ":resize -1<cr>", { silent = true })

-- move lines up/down
vim.keymap.set("i", "<a-j>", "<esc> :move .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc> :move .-2<cr>==gi")
vim.keymap.set("n", "<a-j>", ":move+<cr>")
vim.keymap.set("n", "<a-k>", ":move--<cr>")
vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv=gv")

-- exit on jj and jk
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { silent = true })

-- shortcuts using <leader>
vim.keymap.set("n", "<leader>c", "<cmd>setlocal list!<cr>")
vim.keymap.set("n", "<leader>hc", vim.cmd.DiffviewClose)
vim.keymap.set("n", "<leader>ho", vim.cmd.DiffviewFileHistory)
vim.keymap.set("n", "<leader>i", vim.cmd.InspectTree)
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>p", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>s", "<cmd>setlocal spell!<cr>")
vim.keymap.set("n", "<leader>t", vim.cmd.TroubleToggle)
vim.keymap.set("n", "<leader>x", vim.cmd.bdelete)

-- toggle fish shell
vim.keymap.set("n", "<leader>j", ":20split term://fish<cr>")
vim.keymap.set("n", "<leader>v", ":vsplit term://fish<cr>")
vim.keymap.set("t", "<leader>q", "<c-\\><c-n>:q!<cr>")

-- mappings to move out from terminal to other views
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")

-- remain in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- search matches in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- center the view after jumping up/down
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")

-- automatically switch to insert mode when entering a term buffer
vim.api.nvim_command("autocmd TermOpen,BufEnter term://* startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")

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

-- :W sudo saves the file
-- (useful for handling the permission-denied error)
vim.api.nvim_create_user_command("W", "w !sudo tee > /dev/null %", {})

-- set statusline
Statusline = function()
  return table.concat {
    "%#statusline#",
    "%F",
    "%h%w%m%r",
    "%=",
    -- "%-14.(%P (%l,%c)%)%L",
    "%-14.(%l,%c%V%) %P",
  }
end

vim.opt.statusline = "%!v:lua.Statusline()"

-- configure telescope
-- see `:help telescope` and `:help telescope.setup()`
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
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case",  the default case_mode is "smart_case"
      },
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        time_format = "",
        saved_only = false,
      },
      file_browser = {
        theme = "ivy",
        -- mappings = {
        --   ["i"] = {
        --     -- your custom insert mode mappings
        --   },
        --   ["n"] = {
        --     -- your custom normal mode mappings
        --   },
        -- },
      },
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

-- configure treesitter
-- see `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "fish",
    "go",
    "gomod",
    "gowork",
    "javascript",
    "json",
    "lua",
    "python",
    "query",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
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
      init_selection = "<c-space>", -- maps in normal mode to init the node/scope selection with space
      node_incremental = "<c-space>", -- increment to the upper named parent
      node_decremental = "<bs>", -- decrement to the previous node
      scope_incremental = "<tab>", -- increment to the upper scope (as defined in locals.scm)
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
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["at"] = "@comment.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>b"] = "@parameter.inner",
      },
    },
  },
}

-- LSP settings
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

-- configure nvim-cmp
-- see `:help cmp`
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
    ["<tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "nvim_lsp_signature_help" },
  }),
})

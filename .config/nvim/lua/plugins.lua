local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path})
end
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Packer can manage itself
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use { "L3MON4D3/LuaSnip", tag = "v2.*", run = "make install_jsregexp" }
  use { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } }
  use { "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" }
  use { "akinsho/toggleterm.nvim", tag = '*' }
  use { "nvim-telescope/telescope.nvim", tag = "0.1.2", requires = { {"nvim-lua/plenary.nvim"} }}
  use "wakatime/vim-wakatime"
  use "sindrets/diffview.nvim"
  use "onsails/lspkind.nvim"
  use "mbbill/undotree"
  use "Shatur/neovim-ayu"
  use "lukas-reineke/indent-blankline.nvim"
  use "fatih/vim-go"
  use "mg979/vim-visual-multi"
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  use "jose-elias-alvarez/null-ls.nvim"
  use "windwp/nvim-autopairs"
  use "folke/trouble.nvim"
  use "lewis6991/gitsigns.nvim"
  use "rafamadriz/friendly-snippets"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "rust-lang/rust.vim"
end)

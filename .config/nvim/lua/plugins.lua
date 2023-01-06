return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "morhetz/gruvbox"
  use "dracula/vim"
  use "sickill/vim-monokai"
  use "sainnhe/sonokai"
  use "folke/tokyonight.nvim"
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "nvim-lua/plenary.nvim"
  use { "nvim-telescope/telescope.nvim", tag = "0.1.0" }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'David-Kunz/cmp-npm'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'voldikss/vim-floaterm'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  use 'dense-analysis/ale'
end)

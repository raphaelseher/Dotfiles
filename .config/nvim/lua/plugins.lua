return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use "morhetz/gruvbox"
  use "dracula/vim"
  use "sainnhe/sonokai"
  use "folke/tokyonight.nvim"
  use "olimorris/onedarkpro.nvim"
  use { 'catppuccin/vim', as = 'catppuccin' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "nvim-lua/plenary.nvim"
  use { "nvim-telescope/telescope.nvim", tag = "0.1.0" }

  use 'neovim/nvim-lspconfig'
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'David-Kunz/cmp-npm'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'voldikss/vim-floaterm'
  use {
  "klen/nvim-test",
  config = function()
    require('nvim-test').setup()
  end
}


  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'rust-lang/rust.vim'

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

end)

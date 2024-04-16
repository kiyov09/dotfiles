-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'ellisonleao/gruvbox.nvim'
  -- use 'gruvbox-community/gruvbox'
  -- use 'sainnhe/gruvbox-material'

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Auto pairs
  use {
	  "windwp/nvim-autopairs",
  }

  -- Integration with the Dash app
  use({ 'mrjones2014/dash.nvim', run = 'make install', })

  -- PostCSS syntax support
  use 'alexlafroscia/postcss-syntax.vim'

  -- From the great tpope
  -- use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-markdown'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'

  -- Commenting (a replacement for vim-commentary)
  use 'numToStr/Comment.nvim'

  -- Show marks (TODO: find a replacement)
  use 'kshenoy/vim-signature'

  -- Integration with tmux
  use 'christoomey/vim-tmux-navigator'

  -- MDX (Markdown with jsx)
  use 'jxnblk/vim-mdx-js'

  -- Dev icons
  use 'kyazdani42/nvim-web-devicons'

  -- LSP
  use 'neovim/nvim-lspconfig'
  -- Progress status for lsp initialisation
  use { 'j-hui/fidget.nvim', tag = 'legacy' }

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets' -- I'll remove this and create my own snippets later

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip' -- Integration with LuaSnip

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
  }
  use 'nvim-treesitter/playground'
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use 'windwp/nvim-ts-autotag'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-live-grep-args.nvim'

  -- Copilot
  use 'github/copilot.vim'

  -- Lua Vim dev
  use { 'ckipp01/stylua-nvim', run = 'cargo install stylua' }
  use 'folke/lua-dev.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  -- None-ls
  use 'nvimtools/none-ls.nvim'

end)

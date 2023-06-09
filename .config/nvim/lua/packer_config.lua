-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'gruvbox-community/gruvbox'
  use 'sainnhe/gruvbox-material'
  use 'folke/tokyonight.nvim'
  use 'Shatur/neovim-ayu'

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
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-markdown'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'

  -- Show marks (TODO: find a replacement)
  use 'kshenoy/vim-signature'

  -- Integration with tmux
  use 'christoomey/vim-tmux-navigator'

  -- Show whitespace at the end of lines
  -- use 'bronson/vim-trailing-whitespace'

  -- Snippets (TODO: find a replacement)
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- MDX (Markdown with jsx)
  use 'jxnblk/vim-mdx-js'

  -- Dev icons
  use 'kyazdani42/nvim-web-devicons'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
  }
  use 'windwp/nvim-ts-autotag'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- Copilot
  use 'github/copilot.vim'

  -- Lua Vim dev
  use { 'ckipp01/stylua-nvim', run = 'cargo install stylua' }
  use 'folke/lua-dev.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'

end)

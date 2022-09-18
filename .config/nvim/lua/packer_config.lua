-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'gruvbox-community/gruvbox'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Airline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- Auto pairs
  -- use 'jiangmiao/auto-pairs'
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
  use 'tpope/vim-markdown'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'

  -- Show marks (TODO: find a replacement)
  use 'kshenoy/vim-signature'

  -- Init screen (TODO: find a replacement)
  use 'mhinz/vim-startify'

  -- Integration with tmux
  use 'christoomey/vim-tmux-navigator'

  -- Show whitespace at the end of lines
  use 'bronson/vim-trailing-whitespace'

  -- Snippets (TODO: find a replacement)
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

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
  use 'quangnguyen30192/cmp-nvim-ultisnips'

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
  use 'folke/lua-dev.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'
end)

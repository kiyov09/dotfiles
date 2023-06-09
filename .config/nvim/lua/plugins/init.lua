local g_opt = vim.g

require('plugins.nvim_cmp')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.fugitive')

-- Only plugins with a large config gets its own file

-- Lualine
require 'lualine'.setup {
  options = {
    theme = 'gruvbox',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
}

-- Dev icons
require 'nvim-web-devicons'.setup {}

-- Auto pairs
require("nvim-autopairs").setup {}

-- Colorizer
g_opt.colorizer_nomap = 1

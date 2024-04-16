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

-- Comment.nvim
require('Comment').setup()

-- nvim treesitter objects
-- TODO: Read docs and configure this properly
require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      --   ['ac'] = '@class.outer',
      --   ['ic'] = '@class.inner',
      },
    },
  },
}

-- none-ls
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.rubocop,
        null_ls.builtins.diagnostics.rubocop,
    },
})

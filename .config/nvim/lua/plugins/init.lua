local g_opt = vim.g

require('plugins.nvim_cmp')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.fugitive')

-- Only plugins with a large config gets its own file

-- Dev icons
require 'nvim-web-devicons'.setup {}

-- Auto pairs
require("nvim-autopairs").setup {}

-- UtiSnips
g_opt.UltiSnipsExpandTrigger = "<tab>"
g_opt.UltiSnipsJumpForwardTrigger = "<c-n>"
g_opt.UltiSnipsJumpBackwardTrigger = "<c-p>"

-- Startify
g_opt.startify_change_to_dir = 0

-- Colorizer
g_opt.colorizer_nomap = 1

local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
  -- windwp/nvim-ts-autotag
  autotag = {
    enable = true
  },
  -- END windwp/nvim-ts-autotag
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {}
  },
  auto_install = true,
  additional_vim_regex_highlighting = false,
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "json",
    "html",
    "css",
    "scss",
    "vim",
    "lua",
    "rust",
    "ruby",
    "toml",
    "markdown",
    "markdown_inline",
  }
}

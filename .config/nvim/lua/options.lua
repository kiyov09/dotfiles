local set = vim.opt

-- Number bar
set.number = true
set.relativenumber = true

-- Search related
set.incsearch = true
set.hlsearch = true

-- Tab related
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.textwidth = 81
set.wrap = true
set.fileformat = "unix"

set.cursorline = true
set.guicursor = 'i:block'
set.scrolloff = 3

set.redrawtime = 5000

set.backspace = { 'indent', 'eol', 'start' }
set.linebreak = true
set.showtabline = 0
set.timeoutlen = 500

set.wildmenu = true
set.foldmethod = 'indent'
set.foldlevel = 99

set.autoindent = true
set.cindent = true

set.signcolumn = 'yes'
set.inccommand = 'split'

-- Enable mouse
set.mouse = 'a'

-- Ignore and smart case search
set.ignorecase = true
set.smartcase = true

-- Better split behavior
set.splitbelow = true
set.splitright = true

-- Colors (move this to a colors config file)
set.termguicolors = true
set.background = 'dark'

-- Status line
set.laststatus = 3

-- Autocomplete (probably should be moved to a config file)
set.completeopt = { 'menu', 'menuone', 'noselect' }

-- Conceal
set.conceallevel = 2
set.concealcursor = 'niv'

-- Files ignored
set.wildignore = { '*.so', '*.swp', '*.pyc', '*.zip', '*.rar' }

-- Set rg as grep program if it exists
if vim.fn.executable('rg') == 1 then
  set.grepprg = 'rg --vimgrep --color=never'
end

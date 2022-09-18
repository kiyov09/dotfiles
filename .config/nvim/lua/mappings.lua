-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

local M = {}

local default_opts = {
  noremap = true,
  silent = true,
}

local function get_mapping_func(mode, opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", default_opts, opts) or default_opts
  return function(lhs, rhs)
    map(mode, lhs, rhs, opts)
  end
end

local nmap = get_mapping_func('n')
local imap = get_mapping_func('i')
local vmap = get_mapping_func('v')

M.nmap = nmap
M.imap = imap
M.vmap = vmap

-- set leader kay as space
vim.g.mapleader = ' '

-- Disable arrow keys completely in Insert Mode
imap('<up>', '<nop>')
imap('<down>', '<nop>')
imap('<left>', '<nop>')
imap('<right>', '<nop>')

-- Map 'j' and 'k' to take wrap lines into account
nmap('j', 'gj')
nmap('k', 'gk')

-- Remap jk to <Esc>
imap('jk', '<Esc>')

-- Search selected text
vmap('//', 'y/<C-R>"<CR>')

-- Save file
nmap('<leader>w', ':w<CR>')

-- Copy to system clipboard
nmap('<leader>y', '"+y')    -- Copy
vmap('<leader>y', '"+y')    -- Copy (visual)
nmap('<leader>yy', '"+yy')  -- Copy the whole line

--  File explorer (netrw)
nmap('<leader>f', ':Explore<CR>')
nmap('<leader>sf', ':Sexplore<CR>')
nmap('<leader>vf', ':Vexplore!<CR>')

-- Use arrow key to resize splits
nmap('<Left>', ':vertical resize -1<CR>')
nmap('<Right>', ':vertical resize +1<CR>')
nmap('<Up>', ':resize -1<CR>')
nmap('<Down>', ':resize +1<CR>')

-- Back to alternate buffer
nmap('<leader><leader>', '<c-^>')

-- Open vertial split from quickfix window
-- nmap('<leader>V', '<C-W><C-K><C-W>v<C-W><C-J><CR>')

-- Move between windows withour CTRL-W
nmap('<C-J>', '<C-W><C-J>')
nmap('<C-K>', '<C-W><C-K>')
nmap('<C-L>', '<C-W><C-L>')
nmap('<C-H>', '<C-W><C-H>')

-- Search in a new split
nmap('<leader>x*', ':split<CR>*')
nmap('<leader>v*', ':vsplit<CR>*')

-- Return the module
return M

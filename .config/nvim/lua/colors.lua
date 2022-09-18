local g_opt = vim.g

g_opt.gruvbox_contrast_dark = 'hard'
g_opt.gruvbox_invert_selection = '0'

vim.cmd [[
  colorscheme gruvbox
]]

-- Airline plugin
g_opt.airline_theme = 'gruvbox'

-- Highlight grupo for match
-- TODO: Convert to lua
vim.cmd [[
  hi MatchGroup cterm=bold ctermfg=231 ctermbg=64 gui=bold guifg=#f8f8f2 guibg=#46830c
]]

-- vnoremap # y:match MatchGroup /<C-R>"/<CR>
-- nnoremap # viwy:match MatchGroup /<C-R>"/<CR>

local get_work_under_cursor = function()
  return vim.fn.expand '<cword>'
end

local nmap = require('mappings').nmap
local vmap = require('mappings').vmap

local M = {}
M.current_match_id = nil

-- Remove match
local remove_match = function ()
  if M.current_match_id then
    vim.fn.matchdelete(M.current_match_id)
    M.current_match_id = nil
  end
end

-- Apply MatchGroup to visual selection (visual mode)
vmap('<leader>#', 'y:match MatchGroup /<C-R>"/<CR>')

-- Apply MathGroup to current word (normal mode)
nmap(
  '<leader>#',
  function()
    remove_match()

    local word = get_work_under_cursor()
    if word == '' then
      return
    end

    M.current_match_id = vim.fn.matchadd('MatchGroup', word)
  end
)

-- Remove MatchGroup
nmap('<leader>r#', remove_match)

return M

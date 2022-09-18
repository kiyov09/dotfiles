-- TODO: Convert all this to lua
vim.cmd [[
  " Fugitive mapping (Move to its own file)
  nmap <leader>gs :Git<cr>
  nmap <leader>gb :Git blame<cr>
  nmap <leader>gpo :Git pull --ff-only origin<space>
  nmap <leader>gpr :Git pull --rebase origin<space>
  nmap <leader>gP :Git push origin<space>
  nmap <leader>gd :Git diff<cr>
  nmap <leader>gl :Gclog -n 100 --<cr>
  nmap <leader>gw :GBrowse<cr>
  " Shows all above mappings (help)
  nmap <leader>g? :map <leader>g<cr>
]]

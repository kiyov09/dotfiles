local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      require('telescope.themes').get_dropdown({})
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

-- Mappings section

local nmap = require('mappings').nmap
local base_map = '<leader>t'

-- Open nvim docs
nmap(base_map .. 'h', function() builtin.help_tags() end)
-- Find files
nmap(base_map .. 'f', function() builtin.find_files({ hidden = true }) end)
-- Live grep
nmap(base_map .. 'g', function() builtin.live_grep() end)
-- Buffers
nmap(base_map .. 'b', function() builtin.buffers() end)
-- Grep string
nmap(base_map .. 's', function() builtin.grep_string() end)

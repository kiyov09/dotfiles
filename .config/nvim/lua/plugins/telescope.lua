local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

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
      -- require('telescope.themes').get_dropdown({})
      themes.get_cursor({})
    },
    live_grep_args = {
      auto_quoting = false,
    }
  },
  defaults = {
    -- layout_strategy = 'vertical',
    layout_strategy = 'bottom_pane',
    layout_config = {
      -- height = 0.75,
      -- width = function(_, max_columns, _)
      --   return math.min(max_columns, 120)
      -- end,
      height = 0.35,
      prompt_position = 'bottom',
    },
  },
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
telescope.load_extension('live_grep_args')

-- Mappings section

local nmap = require('mappings').nmap
local base_map = '<leader>t'

local only_files_layout = {
  -- width = function(_, max_columns, _)
  --   return math.min(max_columns, 100)
  -- end,
  --
  -- height = function(_, _, max_lines)
  --   return math.min(max_lines, 30)
  -- end,
}

-- Open nvim docs
nmap(base_map .. 'h', function() builtin.help_tags() end)

-- Find files
nmap(base_map .. 'f', function() builtin.find_files({
  hidden = true,
  previewer = false,
  layout_config = only_files_layout,
}) end)

-- Live grep
local lg_args = require('telescope').extensions.live_grep_args
nmap(base_map .. 'g', function() lg_args.live_grep_args() end)

-- Buffers
nmap(base_map .. 'b', function() builtin.buffers({
  previewer = false,
  ignore_current_buffer = true,
  sort_lastused = true,
  layout_config = only_files_layout,
}) end)

-- Grep string
nmap(base_map .. 's', function() builtin.grep_string() end)

-- Old files
nmap(base_map .. 'o', function() builtin.oldfiles({
  only_cwd = true,
  previewer = false,
  layout_config = only_files_layout,
}) end)

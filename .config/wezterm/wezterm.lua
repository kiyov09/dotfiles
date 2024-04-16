local wezterm = require 'wezterm';

return {
  -- Colors
  color_scheme = 'Gruvbox dark, hard (base16)',

  -- Font related
  font_size = 15.0,
  font = wezterm.font {
    -- Previous fonts I've tried
    -- family = 'Monaco Nerd Font Mono',
    -- family = 'Monaco for Powerline',
    -- family = 'Red Hat Mono',

    -- Current font family I'm using
    family = 'Liga SFMono Nerd Font',

    -- weight = 'Light',
    weight = 'Regular',
    -- weight = 'Medium',

    stretch = 'Normal',
  },

  -- harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  line_height = 1.25,

  -- Interface
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0,
  },

  -- window_decorations = "RESIZE",

  -- Prevent slow mission control animation (don't know why)
  window_background_opacity = 0.95,

  -- Native MacOS fullscreen
  native_macos_fullscreen_mode = true,

  -- Key bindings
  keys = {
    {
      key = 'Enter',
      mods = 'CMD',
      action = wezterm.action.ToggleFullScreen,
    }
  }
}

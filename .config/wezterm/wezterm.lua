local wezterm = require 'wezterm';

return {
  -- Colors
  color_scheme = "Gruvbox Dark",

  -- Font related
  font_size = 15.0,
  font = wezterm.font {
    -- family = 'Monaco Nerd Font Mono',
    family = 'Monaco for Powerline',
    weight = 'Regular',
    stretch = 'Normal',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
  line_height = 1.3,

  -- Interface
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0,
  },

  -- Prevent slow mission control animation (don't know why)
  window_background_opacity = 0.99,

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

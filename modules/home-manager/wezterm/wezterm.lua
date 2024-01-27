local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end
--color_scheme = 'Batman',
config.enable_tab_bar = true
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}
config.window_background_opacity = 0.87
config.font_size = 14.0
config.window_background_gradient = {
  orientation = 'Vertical',
  colors = {
    '#181818',
  }
}
config.launch_menu = {
  {
    args = { 'btop' },
  },
  {
    args = { 'cmatrix' },
  },
  {
    args = { 'pipes-rs' },
  },
}
-- config.keys = {
--   {
--     key = 'j',
--     mods = 'CTRL|SHIFT',
--     action = act.ScrollByPage(1)
--   },
--   {
--     key = 'k',
--     mods = 'CTRL|SHIFT',
--     action = act.ScrollByPage(-1)
--   },
--   {
--     key = 'g',
--     mods = 'CTRL|SHIFT',
--     action = act.ScrollToTop
--   },
--   {
--     key = 'e',
--     mods = 'CTRL|SHIFT',
--     action = act.ScrollToBottom
--   },
--   {
--     key = 'p',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.PaneSelect
--   },
--   {
--     key = 'o',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.PaneSelect { mode = "SwapWithActive" }
--   },
--   {
--     key = '%',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.SplitVertical { domain = 'CurrentPaneDomain' }
--   },
--   {
--     key = '"',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
--   },
--   {
--     key = 'LeftArrow',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.AdjustPaneSize { 'Left', 1 }
--   },
--   {
--     key = 'RightArrow',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.AdjustPaneSize { 'Right', 1 }
--   },
--   {
--     key = 'UpArrow',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.AdjustPaneSize { 'Up', 1 }
--   },
--   {
--     key = 'DownArrow',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.AdjustPaneSize { 'Down', 1 }
--   },
--   {
--     key = 'h',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.ActivatePaneDirection 'Left'
--   },
--   {
--     key = 'l',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.ActivatePaneDirection 'Right'
--   },
--   {
--     key = 'k',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.ActivatePaneDirection 'Up'
--   },
--   {
--     key = 'j',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.ActivatePaneDirection 'Down'
--   },
--   {
--     key = 'z',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.TogglePaneZoomState
--   },
--   {
--     key = 'q',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.CloseCurrentPane { confirm = true }
--   },
--   {
--     key = 'b',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.RotatePanes 'CounterClockwise'
--   },
--   {
--     key = 'n',
--     mods = 'CTRL|SHIFT|SUPER',
--     action = act.RotatePanes 'Clockwise'
--   },
--   {
--     key = 'd',
--     mods = 'CTRL|SHIFT',
--     action = act.ShowLauncher
--   },
--   {
--     key = ':',
--     mods = 'CTRL|SHIFT',
--     action = act.ClearSelection
--   },
return config

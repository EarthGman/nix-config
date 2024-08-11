local wezterm = require 'wezterm'
--local act = wezterm.action
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
--config.front_end = "WebGpu"
config.window_background_opacity = 0.87
config.font_size = 14.0
config.window_background_gradient = {
  --preset = "Viridis",
  orientation = 'Vertical',
  colors = {
    '#121213',
    '#151517',
    '#161617',
    '#121213'
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
return config


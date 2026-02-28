local wezterm = require 'wezterm'
local config = {}

config.term = "xterm-256color"

wezterm.on("gui-startup", function(cmd)
  local mux = wezterm.mux
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.automatically_reload_config = true

config.font = wezterm.font 'CodeNewRoman Nerd Font'
config.color_scheme = 'Tokyo Night Moon'

config.adjust_window_size_when_changing_font_size = true

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
return config

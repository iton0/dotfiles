local wezterm = require('wezterm')
local config = wezterm.config_builder()

wezterm.on('gui-startup', function()
  ---@diagnostic disable-next-line
  local tab, pane, window = wezterm.mux.spawn_window({})
  window:gui_window():toggle_fullscreen()
end)

-- Configuration
config.color_scheme = 'Everforest Dark Medium (Gogh)'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.enable_tab_bar = false
config.font_size = 17
config.force_reverse_video_cursor = true
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.window_padding = {
  left = 0.75 .. 'cell',
  right = 0 .. 'cell',
  top = 0 .. 'cell',
  bottom = 0 .. 'cell',
}

return config

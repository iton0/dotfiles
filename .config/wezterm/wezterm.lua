local wezterm = require('wezterm')
local config = wezterm.config_builder()

wezterm.on('gui-startup', function()
  ---@diagnostic disable-next-line
  local tab, pane, window = wezterm.mux.spawn_window({})
  window:gui_window():toggle_fullscreen()
end)

-- Configuration
config.colors = {}
config.colors.background = '#101010' -- Neovim colorscheme background

config.allow_square_glyphs_to_overflow_width = 'Always'
config.warn_about_missing_glyphs = false
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.freetype_load_target = 'HorizontalLcd'
config.font_size = 16.45
config.color_scheme = 'Nord (base16)'

config.force_reverse_video_cursor = true
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config

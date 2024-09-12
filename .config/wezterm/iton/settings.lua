local M = {}

M.apply = function(config)
  ---

  -- Colorscheme
  config.color_scheme = 'Solarized Dark (Gogh)'

  -- Visual
  config.allow_square_glyphs_to_overflow_width = 'Always'
  config.warn_about_missing_glyphs = false
  config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
  config.freetype_load_target = 'HorizontalLcd'
  config.font_size = 16.35

  -- Cursor
  config.audible_bell = 'Disabled'
  config.animation_fps = 1
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
  config.default_cursor_style = 'BlinkingBlock'

  -- Window
  config.default_workspace = 'HOME'
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  ---
end

return M

-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- To install/update use link below:
-- https://wezfurlong.org/wezterm/install/linux.html#pre-built-deb-packages
--
-- Does not check for stable updates
config.check_for_updates = false

-- Window Setting
config.initial_cols = 80
config.initial_rows = 25
config.adjust_window_size_when_changing_font_size = false

config.color_scheme = 'Gruvbox dark, pale (base16)'

local dimmer = { brightness = 0.4 }
config.background = {
  {
    source = {
      File = { path = '/home/iton/.config/wezterm/background/2.gif' },
    },
    hsb = dimmer,
    height = 'Cover',
    width = 'Cover',
    horizontal_align = 'Left',
    vertical_align = 'Top',
    repeat_y = 'Mirror',
  },
}

config.window_padding = {
  left = '1.0cell',
  right = '0.25cell',
  top = '0.5cell',
  bottom = '0.25cell',
}

config.window_frame = {
  inactive_titlebar_bg = '#1a1b26',
  active_titlebar_bg = '#1f2335',
  inactive_titlebar_fg = '#6b7280',
  active_titlebar_fg = '#ffffff',
  inactive_titlebar_border_bottom = '#1f2335',
  active_titlebar_border_bottom = '#1f2335',
  button_fg = '#6b7280',
  button_bg = '#1f2335',
  button_hover_fg = '#ffffff',
  button_hover_bg = '#292d47',
  border_left_color = 'black',
  border_right_color = 'black',
  border_bottom_color = 'black',
  border_top_color = 'black',
}

config.window_decorations = 'INTEGRATED_BUTTONS'
config.integrated_title_button_style = 'Gnome'
config.enable_tab_bar = true
config.hide_mouse_cursor_when_typing = true
config.warn_about_missing_glyphs = false

-- Mouse, Cursor, & Keyboard
config.scrollback_lines = 5000
config.alternate_buffer_wheel_scroll_speed = 5
config.use_dead_keys = false
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- Key Bindings
config.disable_default_key_bindings = true
config.keys = require('keybindings')

-- Font settings
config.allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- Turns off ligatures
config.font_size = 19
config.cell_width = 1.0
config.line_height = 1.0
config.unicode_version = 8

-- and finally, return the configuration to wezterm
return config

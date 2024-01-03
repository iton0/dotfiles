-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Color and Appearance
config.color_scheme = 'One Dark (base16)'

config.colors = {
  cursor_border = 'white',
  cursor_bg = '#E5E9F0',
}

config.anti_alias_custom_block_glyphs = true
config.custom_block_glyphs = true
config.allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace'
config.bold_brightens_ansi_colors = 'BrightOnly'

-- Window Setting
config.initial_cols = 80
config.initial_rows = 25
config.adjust_window_size_when_changing_font_size = false

local dimmer = { brightness = 0.25 }
config.background = {

  {
    source = {
      File = { path = '/home/iton/.config/wezterm/background/4.gif' },
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
  left = '0.5cell',
  right = '0.5cell',
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

config.enable_tab_bar = false
config.hide_mouse_cursor_when_typing = true
config.warn_about_missing_glyphs = false

config.enable_wayland = false

-- Mouse, Cursor, & Keyboard
config.scrollback_lines = 5000
config.alternate_buffer_wheel_scroll_speed = 5

config.default_cursor_style = 'SteadyBlock'

config.use_dead_keys = false
config.disable_default_key_bindings = true

-- Key Bindings
local keybindings = require('keybindings')
config.keys = keybindings

-- Font
config.font = wezterm.font('FiraCode Nerd Font')

config.font_size = 15
config.cell_width = 1.0
config.line_height = 1.0
config.unicode_version = 8
config.font_shaper = 'Harfbuzz'
config.freetype_load_target = 'Normal'

-- and finally, return the configuration to wezterm
return config

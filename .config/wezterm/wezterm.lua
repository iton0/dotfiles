-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
   config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Color and Appearance
config.color_scheme = 'tokyonight_storm'

config.anti_alias_custom_block_glyphs = true
config.custom_block_glyphs = false
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.bold_brightens_ansi_colors = "BrightOnly"

-- Window Setting
config.initial_cols = 80
config.initial_rows = 24
config.adjust_window_size_when_changing_font_size = false

local dimmer = { brightness = 0.3 }
config.background = {
   {
      source = {
         File = { path = '/home/iton/.config/wezterm/background/background1.gif' },
      },
      hsb = dimmer,
      height = "Contain",
      width = "Cover",
      horizontal_align = "Left",
      vertical_align = "Top",
      repeat_y = "Mirror",
   },
}
config.window_padding = {
   left = '0px',
   right = '0px',
   top = '0px',
   bottom = '0px',
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
}

config.enable_tab_bar = false
config.hide_mouse_cursor_when_typing = true

config.enable_wayland = false

config.tiling_desktop_environments = {
   'X11 GNOME Shell',
}

-- Mouse & Cursor
config.alternate_buffer_wheel_scroll_speed = 3

config.default_cursor_style = 'SteadyBlock'

-- Font
config.font =
    wezterm.font('FiraCode Nerd Font')

config.font_size = 15
config.cell_width = 1.0
config.line_height = 1.0
config.unicode_version = 8
config.font_shaper = "Harfbuzz"
config.freetype_load_target = "Normal"

-- and finally, return the configuration to wezterm
return config

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
config.color_scheme = 'Tokyo Night Day (Gogh)'

config.anti_alias_custom_block_glyphs = true
config.bold_brightens_ansi_colors = "BrightAndBold"

-- Window Setting
config.initial_cols = 80
config.initial_rows = 24


config.window_background_image = '/home/iton/.config/wezterm/background.gif'

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.3,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}

config.window_padding = {
	left = '0cell',
	right = '0cell',
	top = '0cell',
	bottom = '0cell',
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


-- Font
config.font =
    wezterm.font('FiraCode Nerd Font')

config.font_size = 15
config.cell_width = 1.0
config.line_height = 1.0

-- and finally, return the configuration to wezterm
return config

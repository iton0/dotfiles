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
config.color_scheme = 'Tokyo Night (Gogh)'

config.colors = {
   cursor_bg = "#FFD700",
   cursor_fg = 'black',
}

config.anti_alias_custom_block_glyphs = true
config.custom_block_glyphs = true
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.bold_brightens_ansi_colors = "BrightOnly"

-- Window Setting
config.initial_cols = 80
config.initial_rows = 24
config.adjust_window_size_when_changing_font_size = false

local dimmer = { brightness = 0.5 }
config.background = {
   {
      source = {
         File = { path = '/home/iton/.config/wezterm/background/background2.gif' },
      },
      hsb = dimmer,
      height = "Cover",
      width = "Cover",
      horizontal_align = "Left",
      vertical_align = "Top",
      repeat_y = "Mirror",
   },
}
config.window_padding = {
   left = '1px',
   right = '1px',
   top = '1px',
   bottom = '1px',
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

config.tiling_desktop_environments = {
   'X11 GNOME Shell',
}

-- Mouse, Cursor, & Keyboard
config.scrollback_lines = 5000
config.alternate_buffer_wheel_scroll_speed = 5

config.default_cursor_style = 'SteadyBlock'

config.use_dead_keys = false
config.disable_default_key_bindings = true

-- Key Bindings
config.keys = {
   {
      key = 'c',
      mods = 'SUPER',
      action = wezterm.action.CopyTo 'Clipboard',
   },
   {
      key = 'v',
      mods = 'SUPER',
      action = wezterm.action.PasteFrom 'Clipboard',
   },
   {
      key = 'c',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CopyTo 'Clipboard',
   },
   {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.PasteFrom 'Clipboard',
   },
   {
      key = 'Copy',
      action = wezterm.action.CopyTo 'Clipboard',
   },
   {
      key = 'Paste',
      action = wezterm.action.PasteFrom 'Clipboard',
   },
   {
      key = 'Insert',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'PrimarySelection',
   },
   {
      key = 'Insert',
      mods = 'SHIFT',
      action = wezterm.action.PasteFrom 'PrimarySelection',
   },
   {
      key = 'm',
      mods = 'SUPER',
      action = wezterm.action.Hide,
   },
   {
      key = 'n',
      mods = 'SUPER',
      action = wezterm.action.SpawnWindow,
   },
   {
      key = 'n',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnWindow,
   },
   {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.ToggleFullScreen,
   },
   {
      key = '-',
      mods = 'SUPER',
      action = wezterm.action.DecreaseFontSize,
   },
   {
      key = '-',
      mods = 'CTRL',
      action = wezterm.action.DecreaseFontSize,
   },
   {
      key = '=',
      mods = 'SUPER',
      action = wezterm.action.IncreaseFontSize,
   },
   {
      key = '=',
      mods = 'CTRL',
      action = wezterm.action.IncreaseFontSize,
   },
   {
      key = '0',
      mods = 'SUPER',
      action = wezterm.action.ResetFontSize,
   },
   {
      key = '0',
      mods = 'CTRL',
      action = wezterm.action.ResetFontSize,
   },
   {
      key = 't',
      mods = 'SUPER',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
   },
   {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
   },
   {
      key = 'T',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.SpawnTab 'DefaultDomain',
   },
   {
      key = 'w',
      mods = 'SUPER',
      action = wezterm.action.CloseCurrentTab { confirm = true },
   },
   {
      key = '1',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(0),
   },
   {
      key = '2',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(1),
   },
   {
      key = '3',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(2),
   },
   {
      key = '4',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(3),
   },
   {
      key = '5',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(4),
   },
   {
      key = '6',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(5),
   },
   {
      key = '7',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(6),
   },
   {
      key = '8',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(7),
   },
   {
      key = '9',
      mods = 'SUPER',
      action = wezterm.action.ActivateTab(-1),
   },
   {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentTab { confirm = true },
   },
   {
      key = '1',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(0),
   },
   {
      key = '2',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(1),
   },
   {
      key = '3',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(2),
   },
   {
      key = '4',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(3),
   },
   {
      key = '5',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(4),
   },
   {
      key = '6',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(5),
   },
   {
      key = '7',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(6),
   },
   {
      key = '8',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(7),
   },
   {
      key = '9',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTab(-1),
   },
   {
      key = '[',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.ActivateTabRelative(-1),
   },
   {
      key = 'Tab',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateTabRelative(-1),
   },
   {
      key = 'PageUp',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(-1),
   },
   {
      key = ']',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.ActivateTabRelative(1),
   },
   {
      key = 'Tab',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
   },
   {
      key = 'PageDown',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
   },
   {
      key = 'PageUp',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.MoveTabRelative(-1),
   },
   {
      key = 'PageDown',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.MoveTabRelative(1),
   },
   {
      key = 'PageUp',
      mods = 'SHIFT',
      action = wezterm.action.ScrollByPage(-1),
   },
   {
      key = 'PageDown',
      mods = 'SHIFT',
      action = wezterm.action.ScrollByPage(1),
   },
   {
      key = 'r',
      mods = 'SUPER',
      action = wezterm.action.ReloadConfiguration,
   },
   {
      key = 'R',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ReloadConfiguration,
   },
   {
      key = 'k',
      mods = 'SUPER',
      action = wezterm.action.ClearScrollback 'ScrollbackOnly',
   },
   {
      key = 'K',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ClearScrollback 'ScrollbackOnly',
   },
   {
      key = 'L',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ShowDebugOverlay,
   },
   {
      key = 'P',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateCommandPalette,
   },
   {
      key = 'U',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' },
   },
   {
      key = 'f',
      mods = 'SUPER',
      action = wezterm.action.Search { CaseSensitiveString = '' },
   },
   {
      key = 'F',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.Search { CaseSensitiveString = '' },
   },
   {
      key = 'X',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateCopyMode,
   },
   {
      key = 'Space',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.QuickSelect,
   },
   {
      key = '"',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
   },
   {
      key = '%',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
   },
   {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.AdjustPaneSize { 'Left', 1 },
   },
   {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.AdjustPaneSize { 'Right', 1 },
   },
   {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.AdjustPaneSize { 'Up', 1 },
   },
   {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT|ALT',
      action = wezterm.action.AdjustPaneSize { 'Down', 1 },
   },
   {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Left',
   },
   {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Right',
   },
   {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Up',
   },
   {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Down',
   },
   {
      key = 'Z',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.TogglePaneZoomState,
   },
}

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

local wezterm = require('wezterm')
local config = wezterm.config_builder()

wezterm.on('gui-startup', function()
  local _, _, window = wezterm.mux.spawn_window({
    args = {
      'sh',
      '-c',
      'echo "\n\n\\033[4mDotfiles Status\\033[0m" && '
        .. '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch && \n'
        .. '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status -sb && '
        .. 'exec $SHELL; ',
    },
  })
  window:gui_window():toggle_fullscreen()
  window:active_tab():set_title(' ')
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

config.audible_bell = 'Disabled'
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'

config.use_fancy_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Tmux-like configuration
config.default_workspace = 'HOME'
wezterm.on('update-status', function(window, _, _)
  window:set_left_status(' ' .. window:active_workspace() .. ' ')
  local date = wezterm.strftime('%I:%M %p ┃ %b %d %Y ')
  window:set_right_status(wezterm.format({
    { Text = date },
  }))
end)

local act = wezterm.action
local sessionizer = require('sessionizer')
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- tabs
  {
    mods = 'LEADER',
    key = 'c',
    action = wezterm.action_callback(function(window, pane)
      -- Spawn a new tab in the current domain
      window:perform_action(wezterm.action.SpawnTab('CurrentPaneDomain'), pane)

      -- Set to a space
      window:active_tab():set_title(' ')
    end),
  },
  {
    mods = 'LEADER',
    key = 'x',
    action = act.CloseCurrentTab({ confirm = true }),
  },
  {
    mods = 'ALT|SHIFT',
    key = 'L',
    action = act.ActivateTabRelativeNoWrap(1),
  },
  {
    mods = 'ALT|SHIFT',
    key = 'H',
    action = act.ActivateTabRelativeNoWrap(-1),
  },
  {
    mods = 'LEADER',
    key = 'r',
    action = act.PromptInputLine({
      description = 'Enter new tab name',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line == '' then
          window:active_tab():set_title(' ')
        else
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  -- Sessions
  {
    mods = 'LEADER',
    key = 'f',
    action = wezterm.action_callback(sessionizer.open),
  },
  {
    mods = 'LEADER',
    key = 'h',
    action = act.SwitchToWorkspace({
      name = 'HOME',
    }),
  },
  {
    mods = 'LEADER',
    key = 's',
    action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
  },
}

return config

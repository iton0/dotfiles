local wezterm = require('wezterm')

return {
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo('Clipboard'),
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom('Clipboard'),
  },
  {
    key = 'Copy',
    action = wezterm.action.CopyTo('Clipboard'),
  },
  {
    key = 'Paste',
    action = wezterm.action.PasteFrom('Clipboard'),
  },
  {
    key = 'Insert',
    mods = 'CTRL',
    action = wezterm.action.CopyTo('PrimarySelection'),
  },
  {
    key = 'Insert',
    mods = 'SHIFT',
    action = wezterm.action.PasteFrom('PrimarySelection'),
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
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = '=',
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '0',
    mods = 'CTRL',
    action = wezterm.action.ResetFontSize,
  },
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab({ confirm = true }),
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
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ClearScrollback('ScrollbackOnly'),
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
    action = wezterm.action.CharSelect({ copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' }),
  },
  {
    key = 'F',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.Search({ CaseSensitiveString = '' }),
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
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = '%',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Left', 1 }),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Right', 1 }),
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Up', 1 }),
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize({ 'Down', 1 }),
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  {
    key = 'Z',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
}

local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

local home = os.getenv('HOME') .. '/'
local fd = home .. '.local/bin/fd'

local work = home .. 'work/'
local neovim_dev = home .. 'neovim_dev/'
local personal = home .. 'personal/'
local sandbox = home .. 'sandbox/'

M.open = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process({
    fd,
    '-HI',
    '-td',
    '--prune',
    '.',
    neovim_dev,
    work,
    personal,
    sandbox,
    -- add more paths here
  })

  if not success then
    wezterm.log_error('Failed to run fd: ' .. stderr)
    return
  end

  -- fill table with results
  for line in stdout:gmatch('([^\n]*)\n?') do
    local project = line
    local label = project:gsub(home, '')
    local _, _, id = string.find(project, '.*/(.+)/')

    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
      return title
    end
    -- Otherwise, use an single space string for the title
    return ' '
  end

  wezterm.GLOBAL.previous_workspace = window:active_workspace()
  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info('Cancelled')
        else
          wezterm.log_info('Selected ' .. label)
          win:perform_action(
            act.SwitchToWorkspace({
              name = label:match('([^/]+)$'):upper(),
              spawn = { cwd = home .. label },
            }),
            pane
          )
          wezterm.on('format-tab-title', function(tab)
            local title = tab_title(tab)
            return {
              { Text = ' ' .. (tab.tab_index + 1) .. ': ' .. title .. ' ' },
            }
          end)
        end
      end),
      fuzzy = true,
      choices = projects,
    }),
    pane
  )
end

return M

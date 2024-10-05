#!/bin/bash

# delay for five seconds just to make sure
sleep 5

# Launch Firefox and move it to workspace 2
firefox --new-window &
sleep 2 # NOTE: this must be >= 2
wmctrl -r "Mozilla Firefox" -t 1

# Launch Firefox (private mode) and move it to workspace 3
firefox --private-window --new-window &
sleep 2
wmctrl -r "Mozilla Firefox Private Browsing" -t 2

# Launch Wezterm (stays in workspace 1)
wezterm # INFO: run this last due to weird behavior with wmctrl

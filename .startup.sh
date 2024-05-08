#!/bin/bash

# delay for five seconds just to make sure
sleep 5

firefox --setDefaultBrowser &
sleep 2 # NOTE: this must be >= 2
wmctrl -r "Mozilla Firefox" -t 1 # workspace 2

firefox --private-window &
sleep 2
wmctrl -r "Mozilla Firefox Private Browsing" -t 2 # workspace 3

# NOTE: Add more applications here

# (stays in workspace 1)
wezterm & # run this last due to weird behavior with wmctrl

#!/bin/bash

# delay for six seconds just to make sure
sleep 6

# Launch Firefox and move it to workspace 1
firefox --new-window &
sleep 2 # wait for Firefox to open
wmctrl -r "Mozilla Firefox" -t 0

# Launch Terminal and move it to workspace 2
gnome-terminal --full-screen &
sleep 2 # wait for Terminal to open
wmctrl -r "Terminal" -t 1

# Launch Firefox in private mode and move it to workspace 3
firefox --private-window --new-window &
sleep 2 # wait for Firefox to open
wmctrl -r "Mozilla Firefox Private Browsing" -t 2

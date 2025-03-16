#!/bin/bash

# Kill any running swayidle processes first
killall -9 swayidle
# Wait until all swayidle processes are stopped
while pgrep -u $UID -x swayidle >/dev/null; do sleep 1; done
# Start swayidle with the desired timeouts
swayidle -w \
	timeout 20 'pgrep swaylock && systemctl suspend' \
	timeout 600 'swaylock -f -c 000000 && playerctl stop' \
	timeout 900 'systemctl suspend' \
	before-sleep 'swaylock -f -c 000000 && playerctl stop'

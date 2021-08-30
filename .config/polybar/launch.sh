#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Launch the bar
echo "---" | tee -a /tmp/polybar.log
polybar -q main -c "$DIR"/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

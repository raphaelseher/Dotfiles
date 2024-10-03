#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/forest"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get the primary monitor
PRIMARY_MONITOR=$(xrandr --query | grep " primary" | cut -d" " -f1)

# Launch Polybar on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
  if [[ "$m" == "$PRIMARY_MONITOR" ]]; then
    MONITOR=$m polybar -q main -c "$DIR"/config.ini --reload &
  else
    MONITOR=$m polybar -q secondary -c "$DIR"/config.ini --reload &
  fi
done


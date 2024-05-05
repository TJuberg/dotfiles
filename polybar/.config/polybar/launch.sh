#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2

#polybar bar1 &
polybar -m | awk -F ':' '{print "MONITOR="$1" polybar bar1 &"}' | xargs -I '{}' bash -c '{}'
polybar -m | awk -F ':' '{print "MONITOR="$1" polybar bottom &"}' | xargs -I '{}' bash -c '{}'

echo "Bars launched..."

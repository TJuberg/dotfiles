#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2

# Get the list of monitors
monitors=$(polybar -m)

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# Loop through each monitor
echo "$monitors" | while read -r line; do
# Extract the monitor name
monitor_name=$(echo "$line" | cut -d':' -f1)

# Run the polybar commands for each monitor
MONITOR=$monitor_name polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
MONITOR=$monitor_name polybar bottom 2>&1 | tee -a /tmp/polybar2.log & disown
done

#polybar bar1 &
#polybar -m | awk -F ':' '{print "MONITOR="$1" polybar bar1 &"}' | xargs -I '{}' bash -c '{}'
#polybar -m | awk -F ':' '{print "MONITOR="$1" polybar bottom &"}' | xargs -I '{}' bash -c '{}'

echo "Bars launched..."

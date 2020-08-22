#!/bin/sh

# Kill all polybar instances
pkill -9 polybar

# Wait for all polybar instances to die
while pgrep -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar main >> /tmp/polybar1.log 2>&1 &

echo "Bars launched..."

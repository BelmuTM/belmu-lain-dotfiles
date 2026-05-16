#!/bin/bash

# Left-clicking the clock calls this, which flips state and signals waybar.

STATE="$XDG_RUNTIME_DIR/waybar-clock-mode"

[ ! -f "$STATE" ] && echo "time" > "$STATE"

if [ "$(cat "$STATE")" = "time" ]; then
    echo "date" > "$STATE"
else
    echo "time" > "$STATE"
fi

pkill -RTMIN+1 waybar

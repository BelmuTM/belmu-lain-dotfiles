#!/bin/bash

# ┌────────────────────────────────────────────────────────────────┐
# │  _____               _      __      __         _               │
# │ |_   _|__  __ _ __ _| |___  \ \    / /_ _ _  _| |__  __ _ _ _  │
# │   | |/ _ \/ _` / _` | / -_)  \ \/\/ / _` | || | '_ \/ _` | '_| │
# │   |_|\___/\__, \__, |_\___|   \_/\_/\__,_|\_, |_.__/\__,_|_|   │
# │           |___/|___/                      |__/                 │
# │                                                                │
# │ Author: Belmu - https://www.github.com/BelmuTM                 │
# └────────────────────────────────────────────────────────────────┘

DISABLED_FLAG_FILE="$HOME/.config/belmu/settings/waybar-disabled"

if [ -f "$DISABLED_FLAG_FILE" ]; then
    rm "$DISABLED_FLAG_FILE"
    notify-send "Enabled Waybar"
else
    touch "$DISABLED_FLAG_FILE"
    notify-send "Disabled Waybar"
fi

source ~/.config/belmu/scripts/waybar-launch.sh &

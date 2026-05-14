#!/bin/bash

# ┌──────────────────────────────────────────────────────────────────┐
# │  _                      _     __      __         _               │
# │ | |   __ _ _  _ _ _  __| |_   \ \    / /_ _ _  _| |__  __ _ _ _  │
# │ | |__/ _` | || | ' \/ _| ' \   \ \/\/ / _` | || | '_ \/ _` | '_| │
# │ |____\__,_|\_,_|_||_\__|_||_|   \_/\_/\__,_|\_, |_.__/\__,_|_|   │
# │                                             |__/                 │
# │                                                                  │
# │ Author: Belmu - https://www.github.com/BelmuTM                   │
# └──────────────────────────────────────────────────────────────────┘

# -----------------------------------------------------
# Quit all running waybar instances
# -----------------------------------------------------
killall waybar
pkill waybar
sleep 0.5

# -----------------------------------------------------
# Default theme: /THEMEFOLDER;/VARIATION
# -----------------------------------------------------
THEME_STYLE="/top-modern;/top-modern/dark"

# -----------------------------------------------------
# Get current theme information from ~/.config/belmu/settings/waybar-theme.sh
# -----------------------------------------------------

THEME_PATH="$HOME/.config/belmu/settings/waybar-theme.txt"

if [ -f "$THEME_PATH" ]; then
    THEME_STYLE=$(cat "$THEME_PATH")
else
    touch "$THEME_PATH"
    echo "$THEME_STYLE" > "$THEME_PATH"
fi

IFS=';' read -ra arrThemes <<< "$THEME_STYLE"
echo ":: Theme: ${arrThemes[0]}"

if [ ! -f ~/.config/waybar/themes${arrThemes[1]}/style.css ]; then
    THEME_STYLE="/top;/top/dark"
fi

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------
CONFIG_FILE="config"
STYLE_FILE="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f ~/.config/waybar/themes${arrThemes[0]}/config-custom ]; then
    CONFIG_FILE="config-custom"
fi
if [ -f ~/.config/waybar/themes${arrThemes[1]}/style-custom.css ]; then
    STYLE_FILE="style-custom.css"
fi

# Check if waybar-disabled file exists
if [ ! -f "$HOME/.config/belmu/settings/waybar-disabled" ]; then
    waybar -c ~/.config/waybar/themes${arrThemes[0]}/$CONFIG_FILE -s ~/.config/waybar/themes${arrThemes[1]}/$STYLE_FILE &
fi

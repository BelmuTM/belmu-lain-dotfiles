#!/bin/bash

# ┌────────────────────────────────────────────────────────────┐
# │ __      __         _                                       │
# │ \ \    / /_ _ _  _| |__  __ _ _ _                          │
# │  \ \/\/ / _` | || | '_ \/ _` | '_|                         │
# │   \_/\_/\__,_|\_, |_.__/\__,_|_|                           │
# │               |__/                                         │
# │  _____ _                            _ _      _             │
# │ |_   _| |_  ___ _ __  ___ ____ __ _(_) |_ __| |_  ___ _ _  │
# │   | | | ' \/ -_) '  \/ -_|_-< V  V / |  _/ _| ' \/ -_) '_| │
# │   |_| |_||_\___|_|_|_\___/__/\_/\_/|_|\__\__|_||_\___|_|   │
# │                                                            │
# │                                                            │
# │ Author: Belmu - https://www.github.com/BelmuTM             │
# └────────────────────────────────────────────────────────────┘

# -----------------------------------------------------
# Default theme folder
# -----------------------------------------------------
THEMES_PATH="$HOME/.config/waybar/themes"

# -----------------------------------------------------
# Initialize arrays
# -----------------------------------------------------
listThemes=""
listNames=""
listNames2=""

# -----------------------------------------------------
# Read theme folder
# -----------------------------------------------------
sleep 0.2
options=$(find $THEMES_PATH -maxdepth 2 -type d)
for value in $options; do
    if [ ! $value == "$HOME/.config/waybar/themes/assets" ]; then
        if [ ! $value == "$THEMES_PATH" ]; then
            if [ $(find $value -maxdepth 1 -type d | wc -l) = 1 ]; then
                result=$(echo $value | sed "s#$HOME/.config/waybar/themes/#/#g")
                IFS='/' read -ra arrThemes <<<"$result"
                listThemes[${#listThemes[@]}]="/${arrThemes[1]};$result"
                if [ -f $THEMES_PATH$result/config.sh ]; then
                    source $THEMES_PATH$result/config.sh
                    listNames+="$theme_name\n"
                    listNames2+="$theme_name~"
                else
                    listNames+="/${arrThemes[1]};$result\n"
                    listNames2+="/${arrThemes[1]};$result~"
                fi
            fi
        fi
    fi
done

# -----------------------------------------------------
# Show rofi dialog
# -----------------------------------------------------
listNames=${listNames::-2}
choice=$(echo -e "$listNames" | rofi -dmenu -replace -i -config ~/.config/rofi/launchers/type-1/style-7.rasi -no-show-icons -width 30 -p "Themes" -format i)
IFS="~"
input=$listNames2
read -ra array <<<"$input"

# -----------------------------------------------------
# Set new theme by writing the theme information to ~/.config/belmu/settings/waybar-theme.sh
# -----------------------------------------------------
if [ "$choice" ]; then
    echo "Loading waybar theme..."
    echo "${listThemes[$choice + 1]}" > ~/.config/belmu/settings/waybar-theme.txt
    source ~/.config/belmu/scripts/waybar-launch.sh
    notify-send "Waybar Theme changed" "to ${array[$choice]}"
fi

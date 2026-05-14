#!/bin/sh

# ┌────────────────────────────────────────────────┐
# │  _    _                                        │
# │ | |__| |_ ___ _ __                             │
# │ | '_ \  _/ _ \ '_ \                            │
# │ |_.__/\__\___/ .__/                            │
# │              |_|                               │
# │                                                │
# │ Author: Belmu - https://www.github.com/BelmuTM │
# └────────────────────────────────────────────────┘

# Theme you want to generate
THEME="belmu-lain"

# Load pywal colors
. "${HOME}/.cache/wal/colors.sh"

mkdir -p ~/.config/btop/themes

# Output final theme
sed \
    -e "s/{background}/${background}/g" \
    -e "s/{foreground}/${foreground}/g" \
    -e "s/{color0}/${color0}/g" \
    -e "s/{color1}/${color1}/g" \
    -e "s/{color2}/${color2}/g" \
    -e "s/{color3}/${color3}/g" \
    -e "s/{color4}/${color4}/g" \
    -e "s/{color5}/${color5}/g" \
    -e "s/{color6}/${color6}/g" \
    -e "s/{color7}/${color7}/g" \
    -e "s/{color8}/${color8}/g" \
    -e "s/{color9}/${color9}/g" \
    -e "s/{color10}/${color10}/g" \
    -e "s/{color11}/${color11}/g" \
    -e "s/{color12}/${color12}/g" \
    -e "s/{color13}/${color13}/g" \
    -e "s/{color14}/${color14}/g" \
    -e "s/{color15}/${color15}/g" \
    ~/.config/btop/themes/${THEME}.template > ~/.config/btop/themes/${THEME}.theme

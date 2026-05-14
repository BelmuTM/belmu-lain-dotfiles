#!/usr/bin/env bash

# ============================================================
# ascii-banner.sh
#
# Dependencies:
#   sudo pacman -S figlet
#
# Usage:
#   ./ascii-banner.sh "Variables"
#
# Example:
#   ./ascii-banner.sh "Variables" \
#       --subtitle "My awesome configuration variables" \
#       --author "Belmu - https://github.com/BelmuTM" \
#       --padding 2 \
#       --font small \
#       --prefix "#" \
#       --no-author
# ============================================================

TEXT="$1"
shift

# Defaults
PADDING=1
FONT="small"
PREFIX="#"

SUBTITLE=""
AUTHOR="Author: Belmu - https://www.github.com/BelmuTM"
NO_AUTHOR=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --padding)
            PADDING="$2"
            shift 2
            ;;
        --font)
            FONT="$2"
            shift 2
            ;;
        --subtitle)
            SUBTITLE="$2"
            shift 2
            ;;
        --author)
            AUTHOR="$2"
            shift 2
            ;;
        --prefix)
            PREFIX="$2"
            shift 2
            ;;
        --no-author)
            NO_AUTHOR=1
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [[ -z "$TEXT" ]]; then
    echo "Usage: $0 \"Text\" [--subtitle \"...\"] [--author \"...\"] [--padding N] [--font FONT] [--prefix CHAR] [--no-author]"
    exit 1
fi

# Generate ASCII text
ASCII=$(figlet -f "$FONT" "$TEXT")

# Split into lines
mapfile -t LINES <<< "$ASCII"

# Add subtitle (multi-line safe)
if [[ -n "$SUBTITLE" ]]; then
    LINES+=("")
    while IFS= read -r line; do
        LINES+=("$line")
    done <<< "$SUBTITLE"
fi

# Add author unless disabled
if [[ "$NO_AUTHOR" -eq 0 && -n "$AUTHOR" ]]; then
    LINES+=("")
    while IFS= read -r line; do
        LINES+=("$line")
    done <<< "$AUTHOR"
fi

# Find max width AFTER all additions
MAX_WIDTH=0
for LINE in "${LINES[@]}"; do
    LEN=${#LINE}
    (( LEN > MAX_WIDTH )) && MAX_WIDTH=$LEN
done

INNER_WIDTH=$((MAX_WIDTH + PADDING * 2))

# Top border
echo "$PREFIX ┌$(printf '─%.0s' $(seq 1 $INNER_WIDTH))┐"

# Content
for LINE in "${LINES[@]}"; do
    printf "%s │%*s%-*s%*s│\n" \
        "$PREFIX" \
        "$PADDING" "" \
        "$MAX_WIDTH" "$LINE" \
        "$PADDING" ""
done

# Bottom border
echo "$PREFIX └$(printf '─%.0s' $(seq 1 $INNER_WIDTH))┘"

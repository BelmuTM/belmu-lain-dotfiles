#!/usr/bin/env bash

STATE_FILE="$HOME/.config/belmu/settings/hyprsunset-temp"

ACTION="${1:-toggle}"

PRESETS=(6500 5000 4000 3000 2700)

mkdir -p "$(dirname "$STATE_FILE")"
[[ ! -f "$STATE_FILE" ]] && echo 6500 > "$STATE_FILE"

CURRENT=$(cat "$STATE_FILE")

case "$ACTION" in
  toggle)
    for i in "${!PRESETS[@]}"; do
      if [[ "${PRESETS[$i]}" == "$CURRENT" ]]; then
        NEXT="${PRESETS[$(( (i + 1) % ${#PRESETS[@]} ))]}"
        echo "$NEXT" > "$STATE_FILE"
        pkill hyprsunset; hyprsunset -t "$NEXT" &
        exit 0
      fi
    done

    echo "${PRESETS[1]}" > "$STATE_FILE"
    pkill hyprsunset; hyprsunset -t "${PRESETS[1]}" &
    ;;

  up)
    NEW=$(( CURRENT + 100 > 6500 ? 6500 : CURRENT + 100 ))
    echo "$NEW" > "$STATE_FILE"
    pkill hyprsunset; hyprsunset -t "$NEW" &
    ;;

  down)
    NEW=$(( CURRENT - 100 < 1000 ? 1000 : CURRENT - 100 ))
    echo "$NEW" > "$STATE_FILE"
    pkill hyprsunset; hyprsunset -t "$NEW" &
    ;;

  reset)
    echo 6500 > "$STATE_FILE"
    pkill hyprsunset &
    ;;

esac

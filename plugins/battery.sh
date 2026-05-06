#!/bin/bash

BATT_INFO="$(pmset -g batt)"

PERCENTAGE="$(echo "$BATT_INFO" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')"
PERCENTAGE="${PERCENTAGE:-0}"

if echo "$BATT_INFO" | grep -q "AC Power"; then
  ICON=""
else
  case "$PERCENTAGE" in
    100|9[0-9]) ICON="" ;;
    [6-8][0-9]) ICON="" ;;
    [3-5][0-9]) ICON="" ;;
    [1-2][0-9]) ICON="" ;;
    *)          ICON="" ;;
  esac
fi

sketchybar --set battery icon="$ICON" label="${PERCENTAGE}%"
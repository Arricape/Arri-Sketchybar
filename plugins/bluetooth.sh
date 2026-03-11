#!/bin/bash

# get number of connected devices
get_connected_count() {
    blueutil --connected | wc -l | tr -d ' '
}

# update the icon based on active state & connected device
update_icon() {
    local BT_STATE=$1
    local CONNECTED=$(get_connected_count)

    if [ "$BT_STATE" -eq 1 ] && [ "$CONNECTED" -gt 0 ]; then
        ICON="󰥰"
    elif [ "$BT_STATE" -eq 1 ]; then
        ICON="󰂯"
    else
        ICON="󰂲"
    fi

    sketchybar --set bluetooth icon="$ICON"
}

# Determine current state
CURRENT_STATE=$(blueutil -p | tr -d '\n')

# If clicked, toggle and set NEW_STATE
if [ "$SENDER" = "mouse.clicked" ]; then
    NEW_STATE=$((1 - CURRENT_STATE))
    blueutil -p "$NEW_STATE"
else
    NEW_STATE=$CURRENT_STATE
fi

# Update the icon immediately based on the new state
update_icon "$NEW_STATE"
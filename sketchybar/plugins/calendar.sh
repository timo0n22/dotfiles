#!/bin/bash

# Date/time
LABEL=$(date "+%a %d %b  %H:%M")

# WiFi info
WIFI=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')
[[ -z "$WIFI" ]] && WIFI="Disconnected"

# Uptime
UPTIME=$(uptime | sed 's/.*up //' | sed 's/,.*//' | xargs)

sketchybar --set date label="$LABEL" \
           --set date.wifi label="$WIFI" \
           --set date.uptime label="up $UPTIME"

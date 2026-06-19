#!/bin/bash

STATE=$(echo "$INFO" | jq -r '.state' 2>/dev/null)
TITLE=$(echo "$INFO" | jq -r '.title' 2>/dev/null)
ARTIST=$(echo "$INFO" | jq -r '.artist' 2>/dev/null)

if [ "$STATE" = "playing" ] && [ -n "$TITLE" ]; then
  LABEL="$TITLE"
  [ -n "$ARTIST" ] && LABEL="$ARTIST — $TITLE"
  [ ${#LABEL} -gt 50 ] && LABEL="${LABEL:0:47}..."
  sketchybar --set media icon=󰎆 label="$LABEL" drawing=on
else
  sketchybar --set media drawing=off
fi

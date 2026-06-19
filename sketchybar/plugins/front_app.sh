#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  APP="${INFO:-Finder}"
  CURRENT=$(sketchybar --query front_app | jq -r '.label.value' 2>/dev/null)
  [ "$APP" = "$CURRENT" ] && exit 0

  __icon_map "$APP"

  sketchybar --animate tanh 5 \
             --set front_app icon="$icon_result" label="$APP"
fi

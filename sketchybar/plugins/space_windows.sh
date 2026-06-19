#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

WORKSPACES=$(aerospace list-workspaces --all 2>/dev/null)
if [ -z "$WORKSPACES" ]; then exit 0; fi

while IFS= read -r sid; do
  WINDOWS=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null | sort -u)

  ICON_STRIP=""
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    ICON_STRIP="$ICON_STRIP $icon_result"
  done <<< "$WINDOWS"

  [ -z "$ICON_STRIP" ] && ICON_STRIP="—"

  sketchybar --set "space.$sid" label="$ICON_STRIP"
done <<< "$WORKSPACES"

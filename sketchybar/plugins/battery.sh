#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="";;
  [6-8][0-9]) ICON="";;
  [3-5][0-9]) ICON="";;
  [1-2][0-9]) ICON="";;
  *)          ICON="";;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

STATE_FILE=/tmp/sketchybar_battery_state

if [ "$SENDER" = "mouse.clicked" ]; then
  if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
  else
    touch "$STATE_FILE"
  fi
fi

if [ -f "$STATE_FILE" ] && [[ "$CHARGING" = "" ]]; then
  LABEL=$(pmset -g batt | grep -Eo "[0-9]+:[0-9]+" | head -1)
  [[ -z "$LABEL" ]] && LABEL="${PERCENTAGE}%"
else
  LABEL="${PERCENTAGE}%"
fi

sketchybar --animate tanh 15 --set battery icon="$ICON" label="$LABEL"

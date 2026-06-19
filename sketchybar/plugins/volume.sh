#!/bin/bash

volume_change() {
  VOLUME=$(osascript -e 'output volume of (get volume settings)')
  MUTED=$(osascript -e 'output muted of (get volume settings)')

  if [ "$MUTED" = "true" ] || [ "$VOLUME" = "0" ]; then
    ICON="󰖁"
  elif [ "$VOLUME" -lt 33 ]; then
    ICON="󰕿"
  elif [ "$VOLUME" -lt 67 ]; then
    ICON="󰖀"
  else
    ICON="󰕾"
  fi

  sketchybar --animate tanh 10 \
             --set volume_icon icon="$ICON" label="$VOLUME%" \
             --set volume_slider slider.percentage="$VOLUME"
}

show_popup() {
  sketchybar --set volume_icon popup.drawing=toggle
  sleep 2
  sketchybar --set volume_icon popup.drawing=off
}

mouse_clicked() {
  if [ "$NAME" = "volume_icon" ]; then
    sketchybar --set volume_icon popup.drawing=toggle
  fi
}

slider_drag() {
  VOLUME=$(sketchybar --query volume_slider | jq -r '.slider.percentage')
  osascript -e "set volume output volume $VOLUME"
}

case "$SENDER" in
  "volume_change")   volume_change;;
  "mouse.clicked")   mouse_clicked;;
  "mouse.entered")   sketchybar --set volume_slider slider.knob.drawing=on; slider_drag;;
  "mouse.exited")    sketchybar --set volume_slider slider.knob.drawing=off; sketchybar --set volume_icon popup.drawing=off;;
  *)                 volume_change;;
esac

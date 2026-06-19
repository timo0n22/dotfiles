#!/bin/bash

if [ "$SELECTED" = "true" ]; then
  sketchybar --animate tanh 10 \
             --set "$NAME" \
             background.color=0xffcba6f7 \
             icon.color=0xff1e1e2e \
             label.color=0xff1e1e2e
else
  sketchybar --animate tanh 10 \
             --set "$NAME" \
             background.color=0xcc1e1e2e \
             icon.color=0xffcba6f7 \
             label.color=0xffcba6f7
fi

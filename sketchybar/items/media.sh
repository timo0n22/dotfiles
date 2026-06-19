#!/bin/bash

sketchybar --add item media right \
           --set media icon=󰎆 \
                       icon.color=0xffcba6f7 \
                       label.color=0xffcdd6f4 \
                       label.font="CaskaydiaCove Nerd Font:Bold:13.0" \
                       label.max_chars=50 \
                       background.color=0xcc1e1e2e \
                       background.border_color=0x44cba6f7 \
                       background.border_width=1 \
                       background.corner_radius=8 \
                       background.height=30 \
                       update_freq=3 \
                       script="$PLUGIN_DIR/media.sh" \
                       drawing=off \
           --subscribe media media_change

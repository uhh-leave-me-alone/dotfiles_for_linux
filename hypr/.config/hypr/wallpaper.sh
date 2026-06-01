#!/bin/bash
sleep 2
WALLS="$HOME/Downloads/walls-catppuccin-mocha"
WALL=$(find "$WALLS" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n1)

hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper ",$WALL"
hyprctl hyprpaper unload all

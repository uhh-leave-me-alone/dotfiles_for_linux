#!/bin/bash
WALLS="$HOME/Downloads/walls-catppuccin-mocha"
WALL=$(find "$WALLS" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n1)
swaymsg "output * bg $WALL fill"

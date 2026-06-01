#!/bin/bash
PID=$(hyprctl activewindow -j | python3 -c "import sys, json; print(json.load(sys.stdin).get('pid', ''))")

if [ -n "$PID" ]; then
    kill -9 $PID
fi

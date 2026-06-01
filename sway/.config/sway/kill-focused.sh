#!/bin/bash
PID=$(swaymsg -t get_tree | python3 -c "
import sys, json

def find_focused(node):
    if node.get('focused'):
        return node.get('pid')
    for child in node.get('nodes', []) + node.get('floating_nodes', []):
        result = find_focused(child)
        if result:
            return result

pid = find_focused(json.load(sys.stdin))
if pid:
    print(pid)
")

if [ -n "$PID" ]; then
    kill -9 $PID
fi

#!/usr/bin/env bash

if pgrep -f "waybar.*expanded.jsonc" > /dev/null; then
  pkill -f "waybar.*expanded.jsonc"
else
  waybar -c ~/.config/waybar/expanded.jsonc
fi

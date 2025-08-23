#!/bin/bash
NID=9999

brightnessctl -q set 10%-

BRIGHTNESS=$(brightnessctl get)
BRIGHTNESS_MAX=$(brightnessctl max)
BRIGHTNESS_PERCENT=$(echo "scale=1 ; $BRIGHTNESS / $BRIGHTNESS_MAX * 100" | bc)

notify-send -r $NID -t 1000 "Current brightness: $BRIGHTNESS_PERCENT%"

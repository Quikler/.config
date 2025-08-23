#!/bin/bash
NID=9999
SINK_NAME=$(pactl get-default-sink)
IS_MUTED=$(pactl get-sink-mute $SINK_NAME | grep yes)

if [[ -n $IS_MUTED ]]; then
    pactl set-sink-mute $SINK_NAME 0
    notify-send -r $NID -t 1000 "Speaker is [ON]"
else
    pactl set-sink-mute $SINK_NAME 1
    notify-send -r $NID -t 1000 "Speaker is {OFF}"
fi

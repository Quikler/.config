#!/bin/bash
NID=9999
SOURCE_NAME=$(pactl get-default-source)
IS_MUTED=$(pactl get-source-mute $SOURCE_NAME | grep yes)

if [[ -n $IS_MUTED ]]; then
    pactl set-source-mute $SOURCE_NAME 0
    notify-send -r $NID -t 1000 "Microphone is [ON]"
else
    pactl set-source-mute $SOURCE_NAME 1
    notify-send -r $NID -t 1000 "Microphone is {OFF}"
fi

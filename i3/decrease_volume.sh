#!/bin/bash
NID=9999
SINK_NAME=$(pactl get-default-sink)
SINK_VOLUME=$(pactl get-sink-volume $SINK_NAME | grep "[0-9]*%" -o -m 1 | head -1)
SINK_VOLUME_NORM=${SINK_VOLUME::-1}

if ((SINK_VOLUME_NORM > 0)); then
    pactl set-sink-volume $SINK_NAME -10%
    SINK_NEW_VOLUME=$(($SINK_VOLUME_NORM - 10))
    notify-send -r $NID -t 1000 "Speaker volume: $SINK_NEW_VOLUME%"
else
    notify-send -r $NID -t 1000 "Speaker volume: {MIN}"
fi

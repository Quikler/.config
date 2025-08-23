#!/bin/bash
TOUCHPAD_ID=$(xinput list | grep Touchpad | grep -o 'id=[0-9]\+' | grep -o '[0-9]\+')
xinput disable $TOUCHPAD_ID

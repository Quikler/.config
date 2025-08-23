#!/bin/bash
NID=9999
LANG_COUNT=$(xkblayout-state print "%C")
CURRENT_LANG_NUMBER=$(($(xkblayout-state print "%c") + 1))
if [ $CURRENT_LANG_NUMBER -eq $LANG_COUNT ]; then
    CURRENT_LANG_NUMBER=0
fi

xkblayout-state set $CURRENT_LANG_NUMBER
NEW_LANG=$(xkblayout-state print "%n")
notify-send -t 1000 -r $NID "Current lang: $NEW_LANG"

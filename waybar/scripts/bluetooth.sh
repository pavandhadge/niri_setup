#!/bin/bash

if bluetoothctl show | grep -q "Powered: yes"; then
    device=$(bluetoothctl info | grep "Name:" | cut -d' ' -f2-)
    if [ -n "$device" ]; then
        text=""
        tooltip="Connected to $device"
    else
        text=""
        tooltip="Bluetooth On"
    fi
else
    text=""
    tooltip="Bluetooth Off"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"

#!/bin/bash

if ! nmcli radio wifi | grep -q "enabled"; then
    text="睊"
    tooltip="WiFi Disabled"
else
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    strength=$(nmcli dev wifi | grep '^*' | awk '{print $8}' || echo "0")

    if [ -z "$strength" ] || [ "$strength" = "0" ]; then
        text=""
        tooltip="Connected (no signal info)"
    else
        text=""
        tooltip="WiFi: $ssid\nStrength: $strength%"
    fi
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"

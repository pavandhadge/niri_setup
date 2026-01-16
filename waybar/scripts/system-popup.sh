#!/bin/bash

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
mem=$(free -h | awk '/^Mem:/ {print $3"/"$2}' | sed 's/i//g')
disk=$(df -h / | awk 'NR==2 {print $3" used / "$2" ("$5")"}')
uptime=$(uptime -p | sed 's/up //')
wifi=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2 || echo "Disconnected")
strength=$(nmcli dev wifi | grep '^*' | awk '{print $8}' || echo "N/A")
bt_power=$(bluetoothctl show | grep "Powered:" | awk '{print $2}' | sed 's/yes/On/;s/no/Off/')
bt_device=$(bluetoothctl info | grep "Name:" | cut -d' ' -f2- || echo "None")
bat=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' || echo "N/A")
bat_state=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}' || echo "N/A")
power=$(powerprofilesctl get || echo "N/A")

zenity --info --width=480 --height=420 --title="System Status" --text="\
<b>CPU Usage:</b>        $cpu
<b>Memory:</b>             $mem
<b>Disk (root):</b>        $disk
<b>Uptime:</b>             $uptime

<b>WiFi Network:</b>       $wifi
<b>Signal Strength:</b>    $strength%

<b>Bluetooth:</b>          $bt_power
<b>Connected Device:</b>   $bt_device

<b>Battery:</b>            $bat ($bat_state)
<b>Power Profile:</b>      $power

<b>Kernel:</b>             $(uname -r)"

#!/bin/bash

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
mem=$(free -h | awk '/^Mem:/ {print $3"/"$2}' | sed 's/i//g')

echo "CPU: $cpu   RAM: $mem"

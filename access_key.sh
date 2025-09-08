#!/bin/bash

echo "=== Accessing key ==="
echo "For quit press CTRL+A+K"
sleep 3
screen $(ls /dev/tty*modem* 2>/dev/null | head -n 1) 115200
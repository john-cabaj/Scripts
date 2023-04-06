#!/bin/bash

# set battery charge start threshold to 75%
echo 75 > /sys/class/power_supply/BAT0/charge_start_threshold

# set battery charge start threshold to 80%
echo 80 > /sys/class/power_supply/BAT0/charge_stop_threshold

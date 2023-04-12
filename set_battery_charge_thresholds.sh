#!/bin/bash
# 
# NOTE: Requires systemd .service file similar to below and enabled to use
#
# Description = Setting battery charge thresholds
# 
# [Service]
# Type=simple
# ExecStart=/usr/bin/bash -c /home/john/Scripts/set_battery_charge_thresholds.sh
# 
# [Install]
# WantedBy=multi-user.target

# set battery charge start threshold to 75%
echo 75 > /sys/class/power_supply/BAT0/charge_start_threshold

# set battery charge start threshold to 80%
echo 80 > /sys/class/power_supply/BAT0/charge_stop_threshold

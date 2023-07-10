#!/bin/bash

echo  "Cleaning up APT cache in Ubuntu..."
echo "APT cache size before"
sudo du -sh /var/cache/apt
sudo apt-get clean
echo "APT cache size after"
sudo du -sh /var/cache/apt

echo "Clearing systemd journal logs (except last 2 days)"
echo "Systemd journal log size before..."
journalctl --disk-usage
sudo journalctl --vacuum-time=2d
echo "Systemd journal log size after..."
journalctl --disk-usage

echo "Removing older versions of Snap applications..."
echo "Snap applications size before"
du -h /var/lib/snapd/snaps
sudo ~/Scripts/clear_snaps.sh
echo "Snap applications size after"
du -h /var/lib/snapd/snaps

echo "Cleaning the thumbnail cache..."
echo "Thumbnail cache size before"
du -sh ~/.cache/thumbnails
rm -rf ~/.cache/thumbnails/*
echo "Thumbnail cache size after"
du -sh ~/.cache/thumbnails

echo "Cleaning the cache..."
echo "Cache size before"
du -sh ~/.cache/
rm -rf ~/.cache/*
echo "Cache size after"
du -sh ~/.cache/

echo "Clearing old kernel config files..."
sudo apt-get remove --purge $(dpkg -l | awk '/^rc/{print $2}')

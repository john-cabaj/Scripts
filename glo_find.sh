#!/bin/bash
	
if command -v rg > /dev/null 2>&1; then
    git log --oneline | rg "$1"
else
    git log --oneline | grep "$1"
fi

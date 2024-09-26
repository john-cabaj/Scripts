#!/bin/bash
	
if command -v rg > /dev/null 2>&1; then
    git log --pretty=oneline | rg -m 1 -i -F "$1"
else
    git log --pretty=oneline | grep -m 1 -i -F "$1"
fi

#!/bin/bash
	
if command -v rg > /dev/null 2>&1; then
    git log --pretty=oneline | rg -i -F "$1"
else
    git log --pretty=oneline | grep -i -F "$1"
fi

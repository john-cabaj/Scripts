#!/bin/bash
./adt-misses.sh $1 | while read u; do ./adt-retrigger.sh "$u"; done

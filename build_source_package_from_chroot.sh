#!/bin/bash

count=0
cmd="sbuild -s --no-arch-any --no-arch-all"

for arg
do
    if [ "$count" -eq 0 ]
    then
        cmd+=" -d $arg"
    else
        cmd+=" --debbuildopt="
        cmd+=$arg
    fi
    let count=count+1
done

echo $cmd
eval "$cmd"

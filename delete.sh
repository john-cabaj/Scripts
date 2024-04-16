#!/bin/bash

for arg in "$@"
do
    gio trash $arg
done

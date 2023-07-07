#!/bin/bash

SHA_RANGE=$1
git show -s --format="%h (\"%s\")" $SHA_RANGE

#!/bin/bash

VM_NAME=$1
USER=$2

lxc exec $VM_NAME -- su --login $USER


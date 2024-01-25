#!/bin/bash

RELEASE=$1

cranky chroot run -u root $RELEASE:linux -- /bin/bash

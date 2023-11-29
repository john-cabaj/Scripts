#!/bin/bash

# Clean the containing tree to ensure ancillaries are instantiated.
debian/rules clean
for ancillary in debian/ancillary/*
do
    (
        cd "$ancillary" || exit 1
        # Clean and package each ancillary.
        debian/rules clean
        dpkg-buildpackage -nc -S
    )
done

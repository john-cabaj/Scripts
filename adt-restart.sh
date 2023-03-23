#!/bin/bash

function adt_query_state {
    STATE=$1
    URL=$2

    url=$(echo "$URL" | sed -e 's/\.html$/.retry/')

    curl -s "$url" | awk -v state="$STATE" '($1 == state) { print $2 }'
}

function adt_retrigger {
    URL=$1
    link=
    package=
    release=

    usage()
    {
        echo RETRIGGER_LINK
        exit 1
    }

    link="$URL"
    package="`echo $link|sed -e 's/^.*package=//'`"
    echo package=$package
    release="`echo $link|sed -e 's/^.*release=//' -e 's/\&.*$//'`"
    echo release=$release


    rmadison $package | grep $release | tail -1 | sed 's;|;;g' | while read p version rest_of_the_line
    do
        CMD="firefox '$link&trigger=$p%2F$version'"
        echo $CMD
        echo $CMD | $SHELL
    done
}

STATE=$1
URL=$2

if [ -z "$STATE" ] || [ -z "$URL" ]; then
	echo "Usage: $0 <state> <retry-url>" 1>&2
	exit 1
fi

adt_query_state $STATE $URL | while read u; do adt_retrigger "$u"; done

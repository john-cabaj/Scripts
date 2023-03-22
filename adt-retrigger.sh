#!/bin/bash

link=
package=
release=

usage()
{
	echo RETRIGGER_LINK
	exit 1
}

link="$1"
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

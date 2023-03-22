# Starts testing for all tests with a MISS state in the matrix. Takes the
# url for the matrix retry file, e.g.
#
#  http://people.canonical.com/~kernel/status/adt-matrix/canonical-kernel-team--ppa/artful-linux-meta.retry

#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <retry-url>" 1>&2
	exit 1
fi
url=$(echo "$1" | sed -e 's/\.html$/.retry/')

curl -s "$url" | awk '($1 == "MISS") { print $2 }' 

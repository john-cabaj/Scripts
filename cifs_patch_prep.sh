#!/bin/bash

LOG=/tmp/log.txt
COMMIT=/tmp/commit.txt
CNUM=0
CIFS_PATH=$1
LINUX_PATH=$2
COMMIT_START=$3
COMMIT_END=$4
LP_BUG_NUM=$5
PATCH_PATH=$6

echo "CIFS path: "$CIFS_PATH
echo "Linux path: "$LINUX_PATH
echo "CIFS starting commit: "$COMMIT_START
echo "CIFS ending commit: "$COMMIT_END
echo "LP Bug Number: "$LP_BUG_NUM
echo "Patch path: "$PATCH_PATH

git -C "$CIFS_PATH" log --pretty=oneline $COMMIT_START^..$COMMIT_END | tac > $LOG

cat $LOG | while read c m
do
    cd "$LINUX_PATH"
    echo "$c" "\"$m\""
    let CNUM=$CNUM+1
    glo_find.sh "$m" > $COMMIT
    cd - > /dev/null 2>&1
    PATCH_FILE="$PATCH_PATH"/$(printf "%04d" "$CNUM").patch
    if [ ! "`cat $COMMIT|wc -l`" = "1" ]
    then
        git -C "$CIFS_PATH" format-patch -1 $c --stdout | sed "s/\[PATCH\]/\[PATCH\] UBUNTU\: SAUCE\:/" > $PATCH_FILE
    else
        C=`sed 's/ .*//' $COMMIT`
        git -C "$CIFS_PATH" format-patch -1 $c --stdout | sed "s/\(^---\$\)/(cherry picked from commit $C)\n\1/" > $PATCH_FILE
    fi

    sed -i "0,/^$/s//\nBugLink\: https\:\/\/bugs.launchpad.net\/bugs\/\n/$LP_BUG_NUM" $PATCH_FILE
done

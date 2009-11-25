#!/bin/sh

DIR=$(readlink -f $0)
DIR=${DIR%/*}
FILE=$DIR/../var/.test1

trap "echo -e \"${0##*/} - $$ got SIGTERM\r\n\" 1>&2 && exit 1" TERM

if [ $# -gt 0 ]; then
    exec sleep $1
    exit 1
elif [ -e $FILE ]; then
    rm -v $FILE
else
    touch $FILE
    while true; do
        if [ ! -e $FILE ]; then
            exit 1
        fi
        sleep 1
    done
fi

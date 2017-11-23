#!/bin/sh

cd /srs-2.0-r2/trunk
if [ "$#" -eq 0 ]
then
    ./objs/srs -c /srs.conf
else
    ./objs/srs "$@"
fi

tail -f objs/srs.log
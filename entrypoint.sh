#!/bin/sh

cd /srs/trunk
if [ -d "/conf/srs.conf" ]; then
    ./objs/srs -c /conf/srs.conf
else
    ./objs/srs -c /srs.conf
fi

tail -f objs/srs.log
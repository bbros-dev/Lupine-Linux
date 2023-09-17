#!/bin/sh

/guest_dev.sh
/guest_net.sh

echo starting lighttpd :\)

lighttpd -D -f /etc/lighttpd/lighttpd.conf
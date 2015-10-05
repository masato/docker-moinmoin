#!/bin/bash

set -eo pipefail

chown -R www-data:www-data /data /usr/local/share/moin/data /usr/local/share/moin/underlay

uwsgi --uid www-data \
    -s /tmp/moin.sock \
    --plugins python \
    --pidfile /var/run/uwsgi-moinmoin.pid \
    --wsgi-file server/moin.wsgi \
    -M -p 4 \
    --chdir /usr/local/share/moin \
    --python-path /usr/local/share/moin \
    --harakiri 30 \
    --daemonize /var/log/uwsgi/app/moinmoin.log
nginx -g 'daemon off;'

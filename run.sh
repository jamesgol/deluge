#!/usr/bin/env bash
set -e

if [ -z "$DELUGED_USER" ]
then
    DELUGED_USER=nobody
fi

# Remove old pid if it exists
[ -f /config/deluged.pid ] && rm -f /config/deluged.pid

# Start Deluge Daemon
/sbin/setuser $DELUGED_USER /usr/bin/deluged -d --config /config --logfile /config/deluged.log --loglevel info

# Start Deluge Web UI
/sbin/setuser $DELUGED_USER /usr/bin/deluge-web --config /config --logfile /config/deluge-web.log --loglevel info

#!/bin/bash

if [ "$SETTINGS_FLAVOR" = "prod" ]; then
  $SETTINGS_FILE="config.json"
else
  $_SETTINGS_FILE="config_$SETTINGS_FLAVOR"
fi

echo """
[supervisord]
nodaemon=true

[program:hipache]
command=/usr/local/bin/hipache -c /usr/local/lib/node_modules/hipache/config/$SETTINGS_FILE
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true

[program:redis]
command=/usr/bin/redis-server
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
""" > /etc/supervisor/conf.d/supervisord.conf

supervisord -n

#!/bin/sh
if [ $(ps -ef | grep -v grep | grep 'php /app/artisan queue2db:consume' | wc -l) -lt 1 ]; then
  exit 1
else
  exit 0
fi
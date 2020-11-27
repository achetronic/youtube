#!/bin/sh
pkill -f "php /app/artisan queue2db:consume"
nohup php /app/artisan queue2db:consume &>/dev/null &
echo "sh /app/runtime/takeover.sh" | at now + 1 hour

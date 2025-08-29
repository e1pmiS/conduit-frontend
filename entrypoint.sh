#!/bin/sh
set -e

# Validate config before start
nginx -t

# Graceful shutdown on container stop
trap 'nginx -s quit || true; exit 0' TERM INT

# Restart loop
while true; do
  nginx -g 'daemon off;' &
  PID=$!
  wait "$PID" || true
  echo "nginx exited (code $?). restarting in 1s"
  sleep 1
done

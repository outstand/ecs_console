#!/bin/dumb-init /bin/sh
set -e

if [ -n "$USE_BUNDLE_EXEC" ]; then
  BINARY="bundle exec ecs_console"
else
  BINARY=ecs_console
fi

if ${BINARY} help "$1" 2>&1 | grep -q "ecs_console $1"; then
  set -- gosu ecs_console ${BINARY} "$@"

  if [ -n "$FOG_LOCAL" ]; then
    chown -R ecs_console:ecs_console /fog
  fi
fi

exec "$@"

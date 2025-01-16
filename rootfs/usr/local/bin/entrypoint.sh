#!/bin/ash
  if [ -z "${1}" ]; then
    set -- amake
  fi

  exec "$@"
#!/bin/sh

rm --force /var/cache/knot-resolver/*
echo -e "Cache cleaner by entrypoint-container.sh"

exec "$@"

#!/bin/bash
set -e

rm --force /var/cache/knot-resolver/*

exec "$@"
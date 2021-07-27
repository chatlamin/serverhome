#!/usr/bin/env bash

# Дергаем страницу firefly-ii-cron
curl http://firefly-iii.serverhome.home:65003/api/v1/cron/65e349ee35414c1a6f4accb3a2624f01
# Дергаем страницу healthchecks-ping-url
curl http://healthchecks.serverhome.home:8000/ping/6eac5c87-6e47-4e36-a7e0-fc43915dcc8e
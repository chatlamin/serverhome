#!/usr/bin/env bash

# Дергаем страницу firefly-ii-cron
curl http://firefly-iii.serverhome.home:65003/api/v1/cron/65e349ee35414c1a6f4accb3a2624f01
# Дергаем страницу healthchecks-ping-url
curl http://healthchecks.serverhome.home:8000/ping/fac2a7ca-142e-4927-b519-43e19cc055cd
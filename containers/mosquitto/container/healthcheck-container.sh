#!/bin/sh
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# Exit immediately if a pipeline, which may consist of a single simple command,
# a list, or a compound command returns a non-zero status
set -e

mosquitto_sub -h localhost -p 1883 -t '#' -u admin -P aireeV7ahk8rah -C 1
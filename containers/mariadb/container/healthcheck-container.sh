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

mysql --host=localhost --port=3306 --user=root --password=uvaeshah3Ohn5i \
  --execute="SELECT version();" \
  2>&1 > /dev/null
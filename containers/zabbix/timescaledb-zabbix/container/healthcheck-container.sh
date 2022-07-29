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

psql postgresql://root:Iecahho1amoo1f@localhost:5432/postgres \
  --command="SELECT version();" \
  2>&1 > /dev/null
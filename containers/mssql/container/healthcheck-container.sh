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

# https://github.com/Microsoft/mssql-docker/issues/133
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P EebaeneP7ahRie -Q "SELECT @@version;" \
  2>&1 > /dev/null
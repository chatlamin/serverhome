#!/bin/sh
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

curl --head --fail --silent --max-time 2 http://localhost:8080 > /dev/null
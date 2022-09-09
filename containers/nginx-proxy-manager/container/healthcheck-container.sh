#!/usr/bin/env bash
#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://nginxproxymanager.com/advanced-config/#docker-healthcheck
/bin/check-health

curl --head --fail --silent --max-time 2 http://localhost:81 > /dev/null

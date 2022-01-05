#!/usr/bin/env bash

#---------------------------------------------------------------------
# Settings
#---------------------------------------------------------------------

source ../settings-personal.sh
source ../../settings/settings-common.sh

#--------------------------------------------------------------------
# End settings
#--------------------------------------------------------------------

# https://github.com/alexanderfefelov/scripts/blob/master/install/ops/install-docker.sh
# Elevate privileges
[ $UID -eq 0 ] || exec sudo bash "$0" "$@"

# https://www.vaultproject.io/api/auth/userpass#sample-payload
curl \
    --request DELETE \
    --header "X-Vault-Token: s.Mil0w5m8AvCipkKOzEJlCQhL" \
    http://vault.serverhome.home:65013/v1/auth/userpass/users/admin
#!/bin/bash

#   Filename    :   custom_profile_settings.sh
#   Description :   Sets various global profile settings


#   Add '/usr/local/bin/custom' directory to PATH ** if it exists **
[[ -d /usr/local/bin/custom ]] && PATH="$PATH:/usr/local/bin/custom"

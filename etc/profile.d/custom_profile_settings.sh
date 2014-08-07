#!/bin/bash

#   Filename    :   custom_profile_settings.sh
#   Description :   Sets various global profile settings


#   1. Add '/usr/local/bin/custom' directory to PATH ** if it exists **
[[ -d /usr/local/bin/custom ]] && PATH="$PATH:/usr/local/bin/custom"

#   2. Enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

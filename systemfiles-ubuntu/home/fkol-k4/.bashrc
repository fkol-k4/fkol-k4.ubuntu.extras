# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global bash.bashrc if it exists
[[ -f /etc/profile ]] && source /etc/profile

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u \[\033[01;30m\]@ $(lsb_release -sd): \[\033[00;31m\]\W/ \[\033[00m\]\$ '
        PS2='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u: Please complete your command \[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]$(lsb_release -sd) - $(uname -r): \[\033[00;30m\]\W/ \[\033[00m\]\$ '
        PS2='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]Please complete your command \[\033[00m\]\$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

##  fkol-k4 additions
##  =================
#   GPG Key
GPG_KEY="AC5A0B22"

#   Aliases
alias fkol_date="date +%Y-%m-%d"
alias fkol_date-with-time="date +%Y-%m-%d-%T"
alias fkol_unhide-applications="sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /usr/share/applications/*.desktop "
alias fkol_unhide-gnome-startups="sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /usr/share/gnome/autostart/*.desktop "
alias fkol_unhide-startups="sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop "
alias fkol_getkey="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "

#   Functions
function fkol_updates() {
    # system updates && cleanup
    sudo apt update
    sudo apt --yes full-upgrade

    sudo apt-get --yes clean
    sudo apt-get --yes autoclean
    sudo apt-get --yes --purge autoremove

    sudo apt-get --yes --fix-missing install
    sudo apt-get --yes --fix-broken install

    sudo dpkg --configure -a

    sync
}

function fkol_DE_reset() {
    # reset DE to defaults
    rm -rf $HOME/.cache
    rm -rf $HOME/.config/dconf
    rm -rf $HOME/.gconf
    rm -rf $HOME/.kde
    rm -rf $HOME/.xfce
    rm -rf $HOME/.cinnamon
}

function fkol_network_restart() {
    # resatrt network systems
    sudo ip addr flush wlp1s0
    sudo systemctl restart networking.service
}


function fkol_disable_NetworkManager_wait_online_service() {
    # disable service
    sudo systemctl disable NetworkManager-wait-online.service
}

function fkol_disable_SnapPackages() {
    # Disable service
    sudo systemctl disable snapd.service
}

function fkol_disable_TouchPad() {
    # Disable Touchpad
    synclient TouchpadOff=1
}

function fkol_enable_TouchPad() {
    # Enable Touchpad
    synclient TouchpadOff=0
}

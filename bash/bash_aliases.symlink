#! /bin/bash

# General aliases
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lah --color=auto"
alias updateupgrade="sudo apt-get update && sudo apt-get upgrade"


# Find a host in $HOME/.hosts, eventually with SSH options $2 
function getHostAtLine() {
    user=$(sed -n "$1p" $HOME/.hosts | awk '{print $1}')
    if [[ $user == "" ]]; then
        # Line does not exist, return 1
        return 1
    fi
    host=$(sed -n "$1p" $HOME/.hosts | awk '{print $2}')
    port=$(sed -n "$1p" $HOME/.hosts | awk '{print $3}')
    if [[ $port == "" ]]; then 
        port="22"
    fi
    echo "ssh -p $port $2 $user@$host"
}


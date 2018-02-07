#! /bin/bash

# General aliases
alias l="ls --color=always"
alias ll="ls -lh --color=always"
alias lla="ls -lah --color=always"

alias k="exa"
alias kk="exa -a"
alias kl="exa -l"
alias kkl="exa -la"

alias updateupgrade="sudo aptitude update && sudo aptitude safe-upgrade"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'

alias mkdir='mkdir -pv'
alias mount='mount |column -t'
alias ports='netstat -tulanp | ccze -A -o nolookups'


# Stay sane and prevent ccze from causing slowdown or logspam in the case of sssd debugging
alias ccze='ccze -A -o nolookups'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

if [[ -x /usr/bin/nvim || -x /usr/local/bin/nvim ]]; then
    alias vim=nvim
fi


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

# Ansible aliases
alias a='ansible'
alias ap='ansible-playbook'
alias al='ansible-pull'
alias avc='ansible-vault create'
alias ave='ansible-vault edit'
alias avr='ansible-vault rekey'
alias avenc='ansible-vault encrypt'
alias avdec='ansible-vault decrypt'
alias avv='ansible-vault view'


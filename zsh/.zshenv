#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi

# Ensure we have the ssh sessions (controlmasters) folder
if [ ! -d ~/.ssh/sessions ]; then
    mkdir -p ~/.ssh/sessions
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    export SSH_AUTH_SOCK
fi

if systemctl --user is-active --quiet ssh_agent; then
    export SSH_AGENT_PID=$(systemctl --user show -p MainPID --value ssh_agent)
elif pgrep ssh-agent > /dev/null; then
    export SSH_AGENT_PID=$(pgrep -o ssh-agent)
else
    export SSH_AGENT_PID=""
fi

if [[ -z "$DOCKER_HOST" ]]; then
    DOCKER_HOST="unix:///run/user/$UID/podman/podman.sock"
    export DOCKER_HOST
fi

# GNUPG
#export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
#export SSH_ASKPASS="~/.local/bin/pinentry.bash"
#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
#export SSH_AGENT_PID=$(systemctl --user show --property MainPID --value ssh-agent)
#systemctl --user show --property MainPID --value ssh-agent

##############################################################################
# Virtualenv
###############################################################################
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel

if (( $+commands[virtualenvwrapper.sh] )) ; then
    source virtualenvwrapper.sh
fi

###############################################################################
# Prompt settings
################################################################################

#
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭──"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─➤ "
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context vi_mode ssh dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv pyenv time battery os_icon)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \UE12E}"
POWERLEVEL9K_DIR_HOME_FOREGROUND="231"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="231"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="231"
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '

###############################################################################
# zsh-syntax-highlighting matches
###############################################################################

# Custom zsh-syntax-highligting matches
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('reboot*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('shutdown*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('halt*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo *' 'fg=white,bold,bg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=('sudoedit *' 'fg=white,bold,bg=yellow')


#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
if (( $+commands[nvim] )); then
  myeditor='/usr/bin/env nvim'
elif (( $+commands[vim] )); then
  myeditor='/usr/bin/env vim'
elif (( $+commands[nano] )); then
  myeditor='/usr/bin/env nano'
else
  myeditor='/usr/bin/env vi'
fi

export EDITOR=$myeditor
export VISUAL=$myeditor
export SUDO_EDITOR=$myeditor
export PAGER=less



#
# Language
#


(( $+commands[locale] )) && function {
  local language
  local languageVars
  local time
  local timeVars
  local locale
  local localeVars
  language=('en_GB.utf8' 'en_US.utf8' 'nb_NO.utf8'
'C.utf8')
  languageVars=('LANG' 'LANGUAGE' 'LC_MESSAGES')
  locale=('nb_NO.utf8' 'en_GB.utf8' 'en_US.utf8' 'C.utf8')
  localeVars=('LC_CTYPE' 'LC_NUMERIC'
'LC_COLLATE' 'LC_MONETARY' 'LC_PAPER' 'LC_NAME'
'LC_ADDRESS' 'LC_TELEPHONE' 'LC_MEASUREMENT'
'LC_IDENTIFICATION')
  timeVars=('LC_TIME')
  time=('en_DK.utf8' 'nb_NO.utf8' 'en_GB.utf8' 'en_US.utf8' 'C.utf8')

  for l in $language; do
    if locale -a | grep -qx $l; then
      for v in $languageVars; do
        export $v=$l
      done
      break
    fi
  done

  for l in $locale; do
    if locale -a | grep -qx $l; then
      for v in $localeVars; do
        export $v=$l
      done
      break
    fi
  done

  for l in $time; do
    if locale -a | grep -qx $l; then
      for v in $timeVars; do
        export $v=$l
      done
      break
    fi
  done

}



#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  ~/.local/bin/
  ~/go/bin/
  ~/.composer/vendor/bin
  ~/.cargo/bin
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi


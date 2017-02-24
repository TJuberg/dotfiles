#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi

###############################################################################
# Virtualenv
###############################################################################
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel

if (( $+commands[virtualenvwrapper.sh] )) ; then
    source virtualenvwrapper.sh
fi

###############################################################################
# Neovim
###############################################################################
#
# True colors for Neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1

###############################################################################
# Prompt settings
###############################################################################

# Frost prompt settings
export FROST_SHOW_CLOCK=0

#
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭──"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="╰─➤ "
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv time load ram battery)
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

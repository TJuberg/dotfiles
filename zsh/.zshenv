#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi

# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel

if (( $+commands[virtualenvwrapper.sh] )) ; then
    source virtualenvwrapper.sh
fi

# Neovim

# True colors for Neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1


# Frost prompt settings
export FROST_SHOW_CLOCK=0




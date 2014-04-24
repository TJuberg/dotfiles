# Use modern completion system
autoload -Uz compinit
compinit

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Don't log my spaces!
# Start a command with a space, it won't get logged!
setopt histignorespace

# Trying something simpler
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Adds slashes to dots! \o/
# When cding, try entering cd .... 
function rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/../
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# Spelling correction
setopt correct

# Host completion
# Will autocomplete hosts with SSH, rsync and scp
if [ -f $HOME/.hosts ]; then
    zstyle ':completion:*:(ssh|rsync|scp):*' hosts "${(f)$(awk '{print $2}' <$HOME/.hosts)}"
fi

# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
ssh() {
    # Do nothing if we are not inside tmux or ssh is called without arguments
    if [[ $# == 0 || -z $TMUX ]]; then
        command ssh $@
        return
    fi
    # The hostname is the last parameter (i.e. ${(P)#})
    local remote=${${(P)#}%.*}
    local old_name="$(tmux display-message -p '#W')"
    local renamed=0
    # Save the current name
    if [[ $remote != -* ]]; then
        renamed=1
        tmux rename-window $remote
    fi
    command ssh $@
    if [[ $renamed == 1 ]]; then
        tmux rename-window "$old_name"
    fi
}


# Enable cache for completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt extended_glob

# Some environmental/shell pref stuff
setopt EXTENDED_HISTORY # puts timestamps in the history
setopt ALL_EXPORT

# Colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

# Prompt
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_BLUE%n$PR_WHITE@$PR_GREEN%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR%(!.#.$) "

# For macbook
if which battery &> /dev/null; then
    RPROMPT="$PR_NO_COLOR%D{[%H:%M} -$(battery)$PR_NO_COLOR]$PR_NO_COLOR"
else
    RPROMPT="$PR_LIGHT_WHITE%D{[%H:%M]}$PR_NO_COLOR"
fi

# Fix home, end and delete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

# Allow comments interactive shell
setopt interactivecomments

# Load aliases
if [[ -s ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Suggest package for command not found
if [[ -s /etc/zsh_command_not_found ]]; then
    . /etc/zsh_command_not_found
fi

SUPDIR=~/.dotfiles-support

if [ ! -d $SUPDIR ]; then
    echo "First time setup, this might spam a bit"
    echo "Beware that this script will fetch numerous resources from third party git repositories."
    echo "To remove these resources and all my dotfiles, delete the SUPDIR and dotfiles folders."
fi

mkdir -p $SUPDIR

# Set editor to vim
if [[ -x /usr/bin/vim ]]; then
    export EDITOR='vim'

    mkdir -p ~/.vim/autoload ~/.vim/bundle

    # Install vundle
    if [ ! -d ~/.vim/bundle/vundle ]; then
        echo "Could not find vim vundle, downloading..."
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    fi
fi

# Download zsh-syntax-highlighting
if [ ! -d $SUPDIR/zsh-syntax-highlighting ]; then
    echo "Could not find zsh-syntax-highlighting, downloading.."
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $SUPDIR/zsh-syntax-highlighting &> /dev/null
fi

# cd $SUPDIR/zsh-syntax-highlighting; git pull &> /dev/null

source $SUPDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Dircolors
if [ ! -d $SUPDIR/dircolors-solarized ]; then
    echo "Downloading dircolors..."
    git clone git://github.com/seebi/dircolors-solarized.git $SUPDIR/dircolors-solarized &> /dev/null
    rm -f ~/.dir_colors
    ln -s $SUPDIR/dircolors-solarized/dircolors.256dark ~/.dir_colors
fi

# cd $SUPDIR/dircolors-solarized; git pull &> /dev/null

eval `dircolors  ~/.dir_colors`


# Link rest of dotfiles
if [ ! -L $HOME/.bash_aliases ]; then
    ln -s $HOME/dotfiles/dot.bash_aliases $HOME/.bash_aliases
fi
if [ ! -L $HOME/.vimrc ]; then
    ln -s $HOME/dotfiles/dot.vimrc $HOME/.vimrc
fi
if [ ! -L $HOME/.tmux.conf ]; then
    ln -s $HOME/dotfiles/dot.tmux.conf $HOME/.tmux.conf
fi

# Add toolkit dir to path, if it exists
if [ -d $HOME/toolkit ]; then
    PATH="$PATH:$HOME/toolkit"
fi

if [ -d $HOME/opt/bin ]; then
     PATH="$HOME/opt/bin:$PATH"
fi

# Set 256 colors
#if [ "$TMUX" = "" ]; then
#	export TERM="xterm-256color"
#else
#	export TERM="screen-256color"
#fi


SSH_ENV=$HOME/.ssh/environment



if [[ -x /usr/bin/ssh-agent ]]; then
    # start the ssh-agent
    function start_agent {
        echo "Initializing new SSH agent..."
        # spawn ssh-agent
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        echo succeeded
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
        /usr/bin/ssh-add
    }

    if [ -f "${SSH_ENV}" ]; then
         . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
fi


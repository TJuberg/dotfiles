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
fi

mkdir -p $SUPDIR
mkdir -p ~/.vim/autoload ~/.vim/bundle

# Set editor to vim
if [[ -x /usr/bin/vim ]]; then
    export EDITOR='vim'

    # Install pathogen
    #if [ ! -d $SUPDIR/vim-pathogen ]; then
    #    echo "Could not find vim-pathogen, downloading..."
    #    git clone git://github.com/tpope/vim-pathogen.git $SUPDIR/vim-pathogen  &> /dev/null
    #    ln -s $SUPDIR/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim 
    #fi  

    # cd $SUPDIR/vim-pathogen; git pull  &> /dev/null

    # Solarize vim
    #if [ ! -d $SUPDIR/vim-colors-solarized ]; then
    #    echo "Could not find vim-colors-solarized, downloading..."
    #    git clone git://github.com/altercation/vim-colors-solarized.git $SUPDIR/vim-colors-solarized  &> /dev/null
    #    ln -s $SUPDIR/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized
    #fi

    # cd $SUPDIR/vim-colors-solarized; git pull  &> /dev/null

fi

# Check if we are on a desktop system
if [[ -x /usr/bin/gnome-terminal ]]; then
    if [ ! -d $SUPDIR/gnome-terminal-colors-solarized ]; then
        echo "gnome-terminal detected, solarizing..."
        git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git $SUPDIR/gnome-terminal-colors-solarized &> /dev/null
        $SUPDIR/gnome-terminal-colors-solarized/install.sh
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
    ln -s $SUPDIR/dircolors-solarized/dircolors.256dark ~/.dir_colors
fi

# cd $SUPDIR/dircolors-solarized; git pull &> /dev/null

eval `dircolors  ~/.dir_colors`


# Link rest of dotfiles
if [ ! -L $HOME/.bash_aliases ]; then
    ln -s $HOME/dotfiles/dot.bash_aliases $HOME/.bash_aliases
fi
#if [ ! -L $HOME/.vimrc ]; then
#    ln -s $HOME/dotfiles/dot.vimrc $HOME/.vimrc
#fi
if [ ! -L $HOME/.tmux.conf ]; then
    ln -s $HOME/dotfiles/dot.tmux.conf $HOME/.tmux.conf
fi

# Download vim spell check
#vimSpellFolder="/usr/share/vim/`ls -1 /usr/share/vim | egrep "vim[0-9]{2}"`/spell/"
#if [[ ! -f $vimSpellFolder/nb.latin1.spl || ! -f $vimSpellFolder/nb.utf-8.spl ]]; then
#    echo "Downloading Norwegian vim spell files"
#    sudo wget http://ftp.vim.org/vim/runtime/spell/nb.latin1.spl -O $vimSpellFolder/nb.latin1.spl &> /dev/null
#    sudo wget http://ftp.vim.org/vim/runtime/spell/nb.latin1.sug -O $vimSpellFolder/nb.latin1.sug &> /dev/null
#    sudo wget http://ftp.vim.org/vim/runtime/spell/nb.utf-8.spl -O $vimSpellFolder/nb.utf-8.spl &> /dev/null
#    sudo wget http://ftp.vim.org/vim/runtime/spell/nb.utf-8.sug -O $vimSpellFolder/nb.uft-8.sug &> /dev/null
#fi

# Add toolkit dir to path, if it exists
if [ -d $HOME/toolkit ]; then
    PATH="$PATH:$HOME/toolkit"
fi

if [ -d $HOME/opt/bin ]; then
     PATH="$HOME/opt/bin:$PATH"
fi

# Set 256 colors
export TERM="xterm-256color"

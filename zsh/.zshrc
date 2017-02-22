#if [[ -x /usr/bin/vim || -x /usr/local/bin/vim || -x /usr/bin/nvim || -x /usr/local/bin/nvim ]]; then
if (( $+commands[nvim] )) || (( $+commands[vim] )); then
    mkdir -p ~/.dein/repos/github.com/Shougo/
    if [ ! -d ~/.dein/repos/github.com/Shougo/dein.vim ]; then
        echo "Could not find dein plugin manager, downloading..."
        git clone https://github.com/Shougo/dein.vim.git ~/.dein/repos/github.com/Shougo/dein.vim
    fi
fi


if [ ! -d ~/.zplug ]; then
    echo "Could not find zplug plugin manager, downloading..."
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# Any  Prezto modules needs to be loaded first
zplug "modules/helper", from:prezto
zplug "modules/git", from:prezto
zplug "modules/python", from:prezto
zplug "modulez/pacman", from:prezto, if:"(( $+commands[pacman] ))"
zplug "modules/dpkg", from:prezto, if:"(( $+commands[dpkg] ))"
zplug "modules/dnf", from:prezto, if:"(( $+commands[dnf] ))"
zplug "modules/gpg", from:prezto
zplug "modules/ssh", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/tmux", from:prezto, if:"(( $+commands[tmux] ))"
zplug "modules/yum", from:prezto, if:"(( $+commands[yum] ))"
zplug "modules/spectrum", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto


zstyle ":prezto:module:editor" key-bindings "vi"
zstyle ":prezto:module:editor" dot-expansion "yes"
zstyle ":prezto:module:ssh:load" identities "id_ecdsa_fei" "id_rsa_git" "id_rsa_tihlde" "id_rsa" "id_ecdsa"
zstyle ":prezto:module:git:status:ignore" submodules "all"
zstyle ":prezto:module:pacman" frontend "pacaur"

zplug "plugins/command-not-found",   from:oh-my-zsh, ignore:oh-my-zsh.sh
zplug "plugins/virtualenv", from:oh-my-zsh, ignore:oh-my-zsh.sh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh, ignore:oh-my-zsh.sh

zplug "mrowa44/emojify", as:command

zplug "sparsick/ansible-zsh", from:github
zplug "arzzen/calc.plugin.zsh", from:github
zplug "djui/alias-tips", from:github
zplug "rimraf/k", from:github
zplug "skx/sysadmin-util", from:github
zplug "zlsun/solarized-man", from:github
zplug "joel-porquet/zsh-dircolors-solarized", from:github
zplug "chrissicool/zsh-256color", from:github
zplug "zsh-users/zsh-completions", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "srijanshetty/zsh-pip-completion", from:github
zplug "bbenne10/goenv", from:github
zplug "mafredri/zsh-async", from:github
zplug "caarlos0/zsh-mkc", from:github
zplug "b4b4r07/enhancd", from:github
zplug "tomfrost/frost-zsh-prompt", use:frost.zsh, from:github, as:theme
zplug "Tarrasch/zsh-autoenv", from:github

# zsh-syntax-highlighting must be loaded before substring-search
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-history-substring-search", from:github

zplug "zplug/zplug", hook-build:"zplug --self-manage"


# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


setupsolarized dircolors.ansi-dark

# zsh-history-substring-search
#
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Ignore ALL duplicates in history
setopt HIST_IGNORE_ALL_DUPS

# end zsh_history-substring-search


# Custom zsh-syntax-highligting matches
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('reboot*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('shutdown*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('halt*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo *' 'fg=white,bold,bg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=('sudoedit *' 'fg=white,bold,bg=yellow')


# make autocompletion faster by caching and prefix-only matching
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# fuzzy matching of completions for when you mistype them
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# get better autocompletion accuracy by typing longer words
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# allow one error for every three characters typed
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' squeeze-slashes true

# completing process IDs with menu selection
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 10
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search


# Load aliases
if [[ -s ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Keep all history
setopt inc_append_history

# Lazy cd
setopt auto_cd
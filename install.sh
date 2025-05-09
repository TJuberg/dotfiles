#!/usr/bin/env bash
#
# bootstrap installs things.

DOTFILES_ROOT="`pwd`"

set -e

echo ''

info () {
    printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
    printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

setup_gitconfig () {
    if ! [ -f git/.gitconfig ]
    then
        info 'setup gitconfig'

        git_credential='cache'

        user ' - What is your github author name?'
        read -e git_authorname
        user ' - What is your github author email?'
        read -e git_authoremail

        git_push=simple

        mkdir -p git
        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" -e "s/GIT_PUSH/$git_push/g" templates/gitconfig.template > git/.gitconfig

        success 'gitconfig'
    fi
}

install_dotfiles () {
  info 'installing dotfiles'

  stow -vv -R -S -t "$HOME" git bash bin gnupg i3 nvim pip polybar terminfo termite tmux vim x zsh alacritty yamllint wireplumber 
  # Removed from stow for now:
  # systemd
}

setup_gitconfig
install_dotfiles

echo ''
echo '  All installed!'

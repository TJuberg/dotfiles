#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

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
  local locale
  local localeVars
  languages=('en_GB.utf8' 'en_US.utf8' 'nb_NO.utf8' 
'C.UTF-8' 'C')
  languageVars=('LANG' 'LANGUAGE' 'LC_MESSAGES')
  locales=('nb_NO.utf8' 'en_GB.utf8' 'en_US.utf8' 'C.UTF-8 
C')
  localeVars=('LC_CTYPE' 'LC_NUMERIC' 'LC_TIME' 
'LC_COLLATE' 'LC_MONETARY' 'LC_PAPER' 'LC_NAME' 
'LC_ADDRESS' 'LC_TELEPHONE' 'LC_MEASUREMENT' 
'LC_IDENTIFICATION')

  for l in $languages; do
    if locale -a | grep -qx $l; then
      for v in $languageVars; do
        export $v=$l
      done
      break
    fi  
  done

  for l in $locales; do
    if locale -a | grep -qx $l; then
      for v in $localeVars; do
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


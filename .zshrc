#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#LANG="C.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

ZSHINITROOT="$HOME/dotfiles"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# linuxとosx、個別にロードしたい設定
if [ `uname` = "Darwin" ]; then
  #mac用のコード
  if [ -f "$ZSHINITROOT/osx.zsh" ]; then
    source "$ZSHINITROOT/osx.zsh"
  fi
elif [ `uname` = "Linux" ]; then
  #Linux用のコード
  if [ -f "$ZSHINITROOT/linux.zsh" ]; then
    source "$ZSHINITROOT/linux.zsh"
  fi
fi

eval $(dircolors ${HOME}/.dircolors )

# rbenv
export PATH="${HOME}/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# wp-completion
autoload bashcompinit
bashcompinit
source $ZSHINITROOT/wp-completion.bash

#alias myssh="ssh $@ && echo $@";
#alias
alias ls="ls --color=auto"
alias cl="clear"
alias sr='screen -RRU'

#percol
function exists { which $1 &> /dev/null }

if exists percol; then
  function percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
  }

  zle -N percol_select_history
  bindkey '^R' percol_select_history

fi

export PATH=~/local/bin:~/bin/:"$PATH"


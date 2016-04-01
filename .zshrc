#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# LANG="C.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

ZSHINITROOT="$HOME/dotfiles"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.prompt" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.prompt"
fi

# Customize to your needs...

# load zshrc.local
if [ -f ${HOME}/.zshrc.local ]; then
  . ${HOME}/.zshrc.local
fi

unset GREP_OPTIONS

# linuxとosx、個別にロードしたい設定
if [ `uname` = "Darwin" ]; then
  # mac用のコード
  if [ -f "$ZSHINITROOT/.zshrc.osx" ]; then
    source "$ZSHINITROOT/osx.zsh"
  fi
elif [ `uname` = "Linux" ]; then
  # Linux用のコード
  if [ -f "$ZSHINITROOT/.zshrc.linux" ]; then
    source "$ZSHINITROOT/.zshrc.linux"
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

agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "no ssh-agent"
fi

# alias
alias ls="ls -G"
alias cl="clear"

alias lg="ls -al|grep"


# screen
alias sr=myScreenLaunch
alias sl='screen -list'
function myScreenLaunch ()
{
  if [ $# -eq 1 ]; then
    screen -x -RR -U -S $1
  else
    screen -x -RR -U -S ${USER}
  fi
}


_srcomp() {
  compadd `screen -list| perl -wne 'if ( $_=~ /[0-9]+\.(\S*)/){ printf $1; printf " "}'`
}

compdef _srcomp sr


# npm
NPM_PACKAGES="${HOME}/.npm-packages"

NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

PATH="$NPM_PACKAGES/bin:$PATH"

##nodebrew
##PATH=$HOME/.nodebrew/current/bin:$PATH
#
## Unset manpath so we can inherit from /etc/manpath via the `manpath`
## command
#unset MANPATH # delete if you already modified MANPATH elsewhere in your config
#MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# prompt color
#function changecolor()
#{
#  local color=$1
#  PROMPT=`echo $PROMPT|awk -v color=$color '{gsub(/135/, color); print $0}'`
#}
#
#if [ ${PROMPTCOLORUSER} ]; then
#  changecolor $PROMPTCOLORUSER
#fi

function colorcode()
{
  for c in {000..015}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%6)) -eq 5 ] && echo;done;echo
  echo
  for c in {016..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($((c-16))%6)) -eq 5 ] && echo;done;echo
}

# aws completion
source /usr/local/bin/aws_zsh_completer.sh

# default editor
EDITOR=`which vim`

# set gopath
export GOPATH=${HOME}/gopath

export PATH=${HOME}/local/bin:~/bin/:${GOPATH}/bin:"$PATH"

if type peco 2>/dev/null 1>/dev/null; then
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  function peco_select_history()
  {
    BUFFER=`history -n 1 | eval $tac | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
  }

  zle -N peco_select_history
  bindkey '^R' peco_select_history
fi

stty -ixon
source ~/.zsh.d/z.sh

function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^s' peco-z-search



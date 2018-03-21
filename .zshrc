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

setopt nonomatch

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.prompt" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.prompt"
fi

# Customize to your needs...
case $OSTYPE in
  darwin*)
    # system-wide environment settings for zsh(1)
    if [ -x /usr/libexec/path_helper ]; then
      eval `/usr/libexec/path_helper -s`
    fi
    ;;
esac

export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}


# load zshrc.local
if [ -f ${HOME}/.zshrc.local ]; then
  . ${HOME}/.zshrc.local
fi

unset GREP_OPTIONS

# linuxとosx、個別にロードしたい設定
if [ `uname` = "Darwin" ]; then
  # mac用のコード
  if [ -f "$ZSHINITROOT/.zshrc.osx" ]; then
    source "$ZSHINITROOT/.zshrc.osx"
  fi
elif [ `uname` = "Linux" ]; then
  # Linux用のコード
  if [ -f "$ZSHINITROOT/.zshrc.linux" ]; then
    source "$ZSHINITROOT/.zshrc.linux"
  fi
fi

# rbenv
export PATH="${HOME}/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# wp-completion
autoload bashcompinit
bashcompinit
source $ZSHINITROOT/wp-completion.bash


# ssh-agent
#agent="$HOME/tmp/ssh-agent-$USER"
#if [ -S "$SSH_AUTH_SOCK" ]; then
#  case $SSH_AUTH_SOCK in
#  /tmp/*/agent.[0-9]*)
#    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
#  esac
#elif [ -S $agent ]; then
#  export SSH_AUTH_SOCK=$agent
#else
#  echo "no ssh-agent"
#fi

keychain --nogui --quiet ~/.ssh/id_rsa
source ~/.keychain/$HOST-sh

# alias
alias cl="clear"

alias lg="ls -al|grep"

alias gosh='rlwrap gosh'

alias ptags='ctags --tag-relative --recurse --sort=yes --exclude=*.js'


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

#screen window title
setopt prompt_subst
function eliptical_pwd {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    echo "$MATCH"
    unset MATCH
  else
    echo "${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
}

case $TERM in
  screen-bce)
    preexec() {
      echo -ne "\ek$1\e\\"
    }
    precmd() {
      echo -ne "\ek$(eliptical_pwd)\e\\"
    }
    ;;
esac



# npm
NPM_PACKAGES="${HOME}/.npm-packages"

NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

export PATH=${NPM_PACKAGES}/bin:${PATH}

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

    #peco and z
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

    # color
    eval $(dircolors ${HOME}/.dircolors )

    # clang
    alias clang-omp='/usr/local/opt/llvm/bin/clang -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
    alias clang-omp++='/usr/local/opt/llvm/bin/clang++ -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'

export PATH=$HOME/.composer/vendor/bin:$PATH

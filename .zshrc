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

fpath=($ZSHINITROOT/zsh $fpath)
path=($HOME/bin $path)

setopt nonomatch

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
else 
  zstyle ':prezto:module:prompt' theme 'mysorin' 9
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

case $OSTYPE in
  darwin*)
    # system-wide environment settings for zsh(1)
    if [ -x /usr/libexec/path_helper ]; then
      eval `/usr/libexec/path_helper -s`
    fi
    if [ -f "$ZSHINITROOT/.zshrc.macos" ]; then
      source "$ZSHINITROOT/.zshrc.macos"
    fi
    ;;
  linux*)
    # Linux用のコード
    if [ -f "$ZSHINITROOT/.zshrc.linux" ]; then
      source "$ZSHINITROOT/.zshrc.linux"
    fi
    ;;
esac

unset GREP_OPTIONS

# linux keychain
if [ "$SSH_TTY" == "" ]; then
  keychain --nogui --quiet ~/.ssh/id_rsa
  source ~/.keychain/$HOST-sh
fi

# alias
alias cl="clear"
alias lp="ls -al|peco"
alias gosh='rlwrap gosh'
alias ptags='ctags --tag-relative --recurse --sort=yes --exclude=*.js'

# promptが更新されない
# function cdup() {
#    cd ..
#    zle reset-prompt
# }
# zle -N cdup
# bindkey '\^' cdup

function starteditor() {
  exec < /dev/tty
  ${EDITOR}
  zle reset-prompt
}
zle -N starteditor
bindkey '^\^' starteditor


# haskell stack
alias ghc='stack ghc --'
alias ghci='stack ghci --'
alias runhaskell='stack runhaskell --'

# screen
alias sl='screen -list'
function sr ()
{
  if [ $# -eq 1 ]; then
    screen -x -RR -U -S $1
  else
    screen -x -RR -U -S ${USER}
  fi
}

_sr() {
   compadd `screen -list| perl -wne 'if ( $_=~ /[1-9]+\.(\S*)/){ printf "$1\n";}'`
}

compdef _sr sr

# screen 表示用
export TERM=xterm-256color
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

# default editor
EDITOR=`which vim`

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

if [ -e "$HOME/.zsh.d/z.sh" ]; then
    source "${HOME}/.zsh.d/z.sh"

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
fi

# history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt EXTENDED_HISTORY
export HISTSIZE=1000
export SAVEHIST=100000

# clang
alias clang-omp='/usr/local/opt/llvm/bin/clang -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
alias clang-omp++='/usr/local/opt/llvm/bin/clang++ -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'


# The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/filriya/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/filriya/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
    if [ -f '/Users/filriya/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/filriya/google-cloud-sdk/completion.zsh.inc'; fi


# SSH/SCP/RSYNC
# :completion:function:completer:command:argument:tag.
# ^Xh
#
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order files hosts-host all-files users hosts-domain hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order hosts-host users hosts-domain users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

zstyle ':completion:*:hosts' hosts

cache_hosts_file="${ZDOTDIR:-$HOME}/.cache_hosts"
print_cache_hosts () {
    if [ ! -f $cache_hosts_file ]; then
        update_cache_hosts
    fi
    print $cache_hosts_file
}
update_cache_hosts () {
    ag -if "Host " ~/.ssh/conf.d |awk '{print $2}'|sort >  $cache_hosts_file
}

_cache_hosts=(print_cache_hosts )

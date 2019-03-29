# LANG="C.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

fpath=(${ZDOTDIR:-$HOME}/.zsh.prompt $fpath)
path=(${ZDOTDIR:-$HOME}/bin $path)

if [ ! -e $HOME/.zsh.bundle/.zprezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zsh.bundle/.zprezto"
fi

if [ ! -e $HOME/.zsh.bundle/z ]; then
    git clone https://github.com/rupa/z.git "${HOME}/.zsh.bundle/z"
fi

setopt nonomatch

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
else 
  zstyle ':prezto:module:prompt' theme 'mysorin' 9
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh.bundle/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh.bundle/.zprezto/init.zsh"
fi

case $OSTYPE in
  darwin*)
    # system-wide environment settings for zsh(1)
    if [ -x /usr/libexec/path_helper ]; then
      eval `/usr/libexec/path_helper -s`
    fi
    if [ -f "${ZDOTDIR:-$HOME}/.zshrc.darwin" ]; then
      source "${ZDOTDIR:-$HOME}/.zshrc.darwin"
    fi
    ;;
  linux*)
    # Linux用のコード
    if [ -f "${ZDOTDIR:-$HOME}/.zshrc.linux" ]; then
      source "${ZDOTDIR:-$HOME}/.zshrc.linux"
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
alias phptags='ctags --tag-relative --recurse --sort=yes --exclude=*.js'

if [[ -f ~/dircolors/dircolors.solarized && -x `which dircolors` ]]; then
  eval `dircolors ${HOME}/dircolors/dircolors.solarized`
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi


function cdup() {
   zle kill-whole-line
   cd ..
   # zle reset-prompt
   zle accept-line
}
zle -N cdup
bindkey '^\^' cdup

bindkey '^q' beginning-of-line

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
function sr()
{
  # 現在アタッチしているscreenのセッション名
  local sty=`echo $STY|perl -pe "s/.*\.(.*)/\1/g"`

  # 何も受け取ってなければユーザー名
  if [ $# -eq 1 ]; then
    local tty=$1
  else
    local tty=${USER}
  fi

  # 現在のscreenのセッションと、パラメータを比較
  #
  if [[ "$sty" =~ ^$tty ]]; then
      # 先頭一致していたら何もしない
      echo "$sty is already attached!"
  elif [[ $sty != "" ]]; then
      # screenにアタッチしていたら、一旦抜ける
      # screen -d $STY

      # TODO この処理がscreen内で処理される(当然)のでうまく動かない
      #screen -x -RR -U -S $tty 
  else 
      screen -x -RR -U -S $tty
  fi
}

alias sl='screen_list'
function screen_list ()
{
   screen -list| perl -wne 'if ( $_=~ /[0-9]+\.(\S*)/){ printf "$1\n";}'
}
_sr() {
   compadd `screen_list`
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

function starteditor() {
  exec < /dev/tty
  ${EDITOR}
  zle reset-prompt
}
zle -N starteditor
bindkey '^@' starteditor

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
    bindkey '^r' peco_select_history
fi

if [ -e "$HOME/.zsh.bundle/z/z.sh" ]; then
    source "${HOME}/.zsh.bundle/z/z.sh"

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

# リポジトリにcd
function peco-repo-list () {
  local ghqroot=`ghq root`
  local selected_dir=`ghq list -p|perl -pse 's/$root\///' -- -root=$ghqroot|peco`
  
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${ghqroot}/${selected_dir} && sr $selected_dir"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-repo-list

bindkey '^t' peco-repo-list

#hub
function git(){hub "$@"}

# history
export HISTFILE=~/.zsh_history #履歴ファイルの設定
export HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
export SAVEHIST=1000000 # ファイルに何件保存するか
setopt extended_history # 実行時間とかも保存する
setopt share_history # 別のターミナルでも履歴を参照できるようにする
setopt hist_ignore_all_dups # 過去に同じ履歴が存在する場合、古い履歴を削除し重複しない 
setopt hist_ignore_space # コマンド先頭スペースの場合保存しない
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_reduce_blanks #余分なスペースを削除してヒストリに記録する
setopt hist_save_no_dups # historyコマンドは残さない
setopt hist_expire_dups_first # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt hist_expand # 補完時にヒストリを自動的に展開する
setopt inc_append_history # 履歴をインクリメンタルに追加 

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

zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order files hosts-host all-files users hosts-domain hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order hosts-host users hosts-domain users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

zstyle ':completion:*:hosts' hosts

if [ "$SSH_TTY" == "" ]; then
    cache_hosts_file="${ZDOTDIR:-$HOME}/.cache_hosts"
    print_cache_hosts () {
        if [ ! -f $cache_hosts_file ]; then
            update_cache_hosts
        fi
        print $cache_hosts_file
    }
    update_cache_hosts () {
        ag -if "Host " ~/.ssh/conf.d |awk '{print $2}'|sort >|  $cache_hosts_file
    }
    update_cache_hosts
    _cache_hosts=(print_cache_hosts )
fi

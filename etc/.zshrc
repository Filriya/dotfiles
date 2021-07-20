#!/bin/zsh
# LANG="C.UTF-8" LC_CTYPE="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANG=ja_JP.UTF-8
# TERM=screen-256color

if [ ! -e "$HOME"/.zsh.bundle/completion ]; then
  mkdir -p "$HOME"/.zsh.bundle/completion
fi

# if [ ! -e "$HOME"/.zsh.bundle/enhancd ]; then
#   git clone https://github.com/b4b4r07/enhancd "${HOME}/.zsh.bundle/enhancd"
# fi

if [ ! -e "$HOME"/.zsh.bundle/completion/_docker ]; then
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > "$HOME"/.zsh.bundle/completion/_docker
  curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose  > "$HOME"/.zsh.bundle/completion/_docker-compose
fi

if [ ! -e "$HOME"/.tmux.bundle/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux.bundle/tpm"
fi

# zinit
if [ ! -e "$HOME"/.zinit/bin/zinit.zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
source "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
zinit light mnowotnik/extra-fzf-completions
zinit light agkozak/zsh-z
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

zinit snippet PZT::modules/editor/init.zsh
zinit snippet PZT::modules/syntax-highlighting/init.zsh
zinit snippet PZT::modules/terminal/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/spectrum/init.zsh
zinit snippet PZT::modules/utility/init.zsh
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/osx/init.zsh
zinit snippet PZT::modules/homebrew/init.zsh
zinit snippet PZT::modules/command-not-found/init.zsh
zinit snippet PZT::modules/docker/alias.zsh


# Source OS-specific settings
case $OSTYPE in
  darwin*)
    # system-wide environment settings for zsh(1)
    if [ -x /usr/libexec/path_helper ]; then
      eval `/usr/libexec/path_helper -s`
    fi
    if [ -f "${ZDOTDIR:-$HOME}/.zsh.d/.zshrc.darwin" ]; then
      source "${ZDOTDIR:-$HOME}/.zsh.d/.zshrc.darwin"
    fi
    ;;
  linux*)
    # Linux用のコード
    if [ -f "${ZDOTDIR:-$HOME}/.zsh.d/.zshrc.linux" ]; then
      source "${ZDOTDIR:-$HOME}/.zsh.d/.zshrc.linux"
    fi
    ;;
esac

# Source *.zsh
ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
  for i in $ZSHHOME/*; do
    [[ ${i##*/} = *.zsh ]] &&
      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi

unset GREP_OPTIONS

unsetopt FLOW_CONTROL
stty stop undef
stty start undef

# fzf
if [ -f ~/.zsh.d/fzf.zsh ]; then
  source ~/.zsh.d/fzf.zsh
fi
EXTRA_FZF_COMPLETIONS_FZF_PREFIX=,
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iterm
# alias it2-light='echo -ne "\033]1337;SetProfile=light\a" && export ITERM_PROFILE=light && tmux source ~/.tmux/light'
# alias it2-dark='echo -ne "\033]1337;SetProfile=dark\a" && export ITERM_PROFILE=dark && tmux source ~/.tmux/dark'

# alias
alias cl="clear"
alias gosh='rlwrap gosh'
alias phptags='ctags --tag-relative --recurse --sort=yes --exclude=*.js'
alias -g F='| fzf'
alias -g N='&& notify completed || notify error'
alias -g P='| pbcopy'
alias -g SJIS='| nkf'

# 反cd
# alias cd='nocd'
symbols() {
  echo "%^&*()-=_+[]{};:'\".,/\\¥<>?"
}
# haskell stack
if type "stack" > /dev/null 2>&1; then
  path=(${ZDOTDIR:-$HOME}/.local/bin $path)
  alias ghci='rlwrap stack ghci'
  alias ghc='stack ghc --'
  alias runghc='stack runghc --'
fi


# exa - alternative ls
if type exa > /dev/null; then
  # "--git" + "-l" + broken symlink + NFS の組み合わせで落ちる
  # alias l="exa --git --group-directories-first"
  # alias ll="exa -l --git --time-style=iso --group-directories-first"
  # alias la="exa -la --git --time-style=iso --group-directories-first"
  # alias lt="exa -lT --git --time-style=iso --group-directories-first -L"
  # alias lT="exa -lT --git --time-style=iso --group-directories-first"

  alias l="exa --group-directories-first"
  alias ll="exa -l --time-style=iso --group-directories-first"
  alias la="exa -la --time-style=iso --group-directories-first"
  alias lt="exa -lT --time-style=iso --group-directories-first -L"
  alias lT="exa -lT --time-style=iso --group-directories-first"
fi

if type exa > /dev/null; then
  alias man="tldr"
fi

if [[ -f ~/dircolors/dircolors.solarized && -x `which dircolors` ]]; then
  eval `dircolors ${HOME}/dircolors/dircolors.solarized`
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# source "$HOME"/.zsh.bundle/enhancd/init.sh


function cdup() {
  zle kill-whole-line
  cd ..
  # zle reset-prompt
  zle accept-line
}
zle -N cdup
bindkey '^^' cdup

bindkey -r '^q'
bindkey '^q' beginning-of-line


# screen
autoload -Uz sr
_sr_comp() {
  compadd `screen_list`
}
compdef _sr_comp sr
alias sl='screen_list'

#tmux
autoload -Uz til
autoload -Uz bk

# リポジトリにcd

function open_project () {
  local command=$(echo-open-project-command)
  if [ -n "$command" ]; then
    BUFFER+=$command
    zle accept-line
  fi
  zle clear-screen
}

zle -N open_project
bindkey '^t' open_project

setopt nonomatch
setopt dotglob

# hub member
function hub-member {
  hub api /orgs/$1/members | perl -pe "s/\,/,\n/g"| grep login | perl -pe 's/.*"login":"(.*)".*/\1/g'
}

# default editor
EDITOR=`which nvim`
export VIMCONFIG="$HOME/.config/nvim"

function starteditor() {
  exec < /dev/tty
  ${EDITOR}
  zle reset-prompt
}
zle -N starteditor
bindkey '^]' starteditor


export HISTSIZE=1000000 # メモリに保存される履歴の件数。(保存数だけ履歴を検索できる)
export SAVEHIST=1000000 # ファイルに何件保存するか
setopt EXTENDED_HISTORY # 実行時間とかも保存する
setopt SHARE_HISTORY # 別のターミナルでも履歴を参照できるようにする
setopt HIST_VERIFY # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt HIST_SAVE_NO_DUPS # historyコマンドは残さない
setopt HIST_EXPIRE_DUPS_FIRST # 古い履歴を削除する必要がある場合、まず重複しているものから削除
setopt HIST_EXPAND # 補完時にヒストリを自動的に展開する
setopt INC_APPEND_HISTORy # 履歴をインクリメンタルに追加
setopt HIST_IGNORE_DUPS # 前と重複する行は記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS # 余分な空白は詰めて記録
setopt HIST_NO_STORE # histroyコマンドは記録しない


# clang
alias clang-omp="$HOMEBREW_PREFIX/opt/llvm/bin/clang -fopenmp -L$HOMEBREW_PREFIX/opt/llvm/lib -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib"
alias clang-omp++="$HOMEBREW_PREFIX/opt/llvm/bin/clang++ -fopenmp -L$HOMEBREW_PREFIX/opt/llvm/lib -Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/filriya/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/filriya/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/filriya/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/filriya/google-cloud-sdk/completion.zsh.inc'; fi

# rg ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# composer
path=(${ZDOTDIR:-$HOME}/.config/composer/vendor/bin $path)

# ruby
path=(/usr/local/lib/ruby/gems/2.6.0 $path)

# yarn
path=($(yarn global bin) $path)

# qt
export PATH="$HOMEBREW_PREFIX/opt/qt/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/qt/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/qt/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/qt/lib/pkgconfig"

# SSH/SCP/RSYNC
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
  find ~/.ssh/conf.d -type f | xargs grep -ih "host " |cut -d ' ' -f 2|sort >|  $cache_hosts_file
}

update_cache_hosts
_cache_hosts=(print_cache_hosts )
fi


export GOPATH=$HOME/go
path=(${GOPATH}/bin $path)

export XDG_CONFIG_HOME="$HOME/.config"

# docker
alias fig='docker-compose'

if [ -e ~/.zsh.bundle/completion ]; then
  fpath=(~/.zsh.bundle/completion $fpath)
fi

autoload -U compinit
compinit

# artisan
alias ar='php `git rev-parse --show-toplevel`/artisan'
alias sf='php `git rev-parse --show-toplevel`/symfony'

# vim
alias vim='nvim'

alias vg='vagrant'

# java
if [ -e /usr/libexec/java_home ];then
  export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
  # export JAVA_HOME="$(/usr/libexec/java_home -v 14)"
fi

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# rust
export RUST_BACKTRACE=1

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# if [[ ! -n $TMUX && -z $SSH_TTY ]]; then
#   tm $(tmux list-sessions | grep attached | perl -pe "s/^([^:]*):.*/\1/g")
# fi

if [ -e "${ZDOTDIR:-$HOME}/.zshrc.local" ]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi

function zgit()
{
  echo $(cat ~/.zsh.d/git.zsh \
    | grep --color=never '^alias' \
    | grep -v 'alias -g'\
    | perl -pe 's/alias ([^=]+)=(.*)/\1\t\2/' \
    | fzf \
    | perl -pe "s/.*['\"]([a-zA-Z \-]+)['\"].*/\1/g"
  )
}
# alias -g Z=zgit

function zdk()
{
  echo $(cat ~/.zinit/snippets/PZT::modules--docker/alias.zsh/alias.zsh \
    | grep --color=never '^alias' \
    | grep -v 'alias -g'\
    | perl -pe 's/alias ([^=]+)=(.*)/\1\t\2/' \
    | fzf \
    | perl -pe "s/.*['\"]([a-zA-Z \-]+)['\"].*/\1/g"
  )
}

fpath=(${ZDOTDIR:-$HOME}/.zsh.d/**/functions $fpath)
path=(${ZDOTDIR:-$HOME}/bin $path)

path=(${ZDOTDIR:-$HOME}/.symfony/bin $path)
typeset -U PATH # 重複削除

# alias -g Z=zgit

### last
# zsh プロファイリング
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
### End of Zinit's installer chunk
### End of Zinit's installer chunk

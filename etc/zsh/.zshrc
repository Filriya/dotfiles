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
  echo hoge
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
    if which tac > /dev/null; then
        local tac="tac"
    else
        local tac="tail -r"
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
    local current_screen_name=`echo $STY|perl -pe "s/.*\.(.*)/\1/g"`
    local screen_name=$(echo $selected_dir|perl -pse 's/[\.\/]/_/g')

    # 現在attach中のscreenと同じなら何もしない
    if [ $current_screen_name = $screen_name ]; then
      echo $screen_name is already attached!
      return 1
    fi
    # if [ ${#current_screen_name} -gt 0 ]; then
    #   BUFFER="screen -d $current_screen_name && "
    # fi
    if sl | grep -x $screen_name > /dev/null; then
      BUFFER+="cd ${ghqroot}/${selected_dir} && screen -d -xRR $screen_name"
    else
      BUFFER+="cd ${ghqroot}/${selected_dir} && screen -d -S $screen_name"
    fi
    # zle accept-line
  fi
  # zle clear-screen
}
zle -N peco-repo-list

bindkey '^t' peco-repo-list

#hub
# function git(){hub "$@"}

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

#
# Defines Git aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# git alias
# zstyle -s ':prezto:module:git:log:medium' format '_git_log_medium_format' \
#   || _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
# zstyle -s ':prezto:module:git:log:oneline' format '_git_log_oneline_format' \
#   || _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
# zstyle -s ':prezto:module:git:log:brief' format '_git_log_brief_format' \
#   || _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'
# Git
alias g='git'

# # Branch (b)
alias gb='git branch --verbose'
alias gba='git branch --all --verbose'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbm='git branch --move'
alias gbM='git branch --move --force'
alias gbs='git show-branch'
alias gbS='git show-branch --all'
# alias gbc='git checkout -b'
# alias gbl='git branch --verbose'
# alias gbL='git branch --all --verbose'
# alias gbr='git branch --move'
# alias gbR='git branch --move --force'
# alias gbv='git branch --verbose'
# alias gbV='git branch --verbose --verbose'
# alias gbx='git branch --delete'
# alias gbX='git branch --delete --force'

# # Commit (c)
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gcf='git commit --verbose --amend --reuse-message HEAD'
alias gca='git commit --verbose --amend'
alias gco='git checkout'
alias gcop='git checkout --patch' # -p
alias gcp='git cherry-pick --ff'
alias gcpn='git cherry-pick --no-commit'
alias gcr='git reset "HEAD^"'
alias gcR='git revert'
alias gcs='git show'
alias gcl='git-commit-lost'
alias gcy='git cherry -v --abbrev'
alias gcY='git cherry -v'
# alias gca='git commit --verbose --all'
# alias gcam='git commit --all --message'
# alias gcS='git commit -S --verbose'
# alias gcSa='git commit -S --verbose --all'
# alias gcSm='git commit -S --message'
# alias gcSf='git commit -S --amend --reuse-message HEAD'
# alias gcSF='git commit -S --verbose --amend'
# alias gcsS='git show --pretty=short --show-signature'

# Conflict (C)
alias gCl='git --no-pager diff --name-only --diff-filter=U'
alias gCa='git add $(gCl)'
alias gCe='git mergetool $(gCl)'
alias gCo='git checkout --ours --'
alias gCO='gCo $(gCl)'
alias gCt='git checkout --theirs --'
alias gCT='gCt $(gCl)'

# Data (d)
alias gd='git ls-files'
alias gdc='git ls-files --cached'
alias gdx='git ls-files --deleted'
alias gdm='git ls-files --modified'
alias gdo='git ls-files --other --exclude-standard'
alias gdk='git ls-files --killed'
alias gdi='git status --porcelain --short --ignored | sed -n "s/^!! //p"'

# Fetch (f)
alias gf='git fetch'
alias gfa='git fetch --all'
alias gfc='git clone --recurse-submodules'
alias gfp='git pull'
alias gfr='git pull --rebase'
# alias gfc='git clone'

# Flow (F)
# alias gFi='git flow init'
# alias gFf='git flow feature'
# alias gFb='git flow bugfix'
# alias gFl='git flow release'
# alias gFh='git flow hotfix'
# alias gFs='git flow support'
#
# alias gFfl='git flow feature list'
# alias gFfs='git flow feature start'
# alias gFff='git flow feature finish'
# alias gFfp='git flow feature publish'
# alias gFft='git flow feature track'
# alias gFfd='git flow feature diff'
# alias gFfr='git flow feature rebase'
# alias gFfc='git flow feature checkout'
# alias gFfm='git flow feature pull'
# alias gFfx='git flow feature delete'
#
# alias gFbl='git flow bugfix list'
# alias gFbs='git flow bugfix start'
# alias gFbf='git flow bugfix finish'
# alias gFbp='git flow bugfix publish'
# alias gFbt='git flow bugfix track'
# alias gFbd='git flow bugfix diff'
# alias gFbr='git flow bugfix rebase'
# alias gFbc='git flow bugfix checkout'
# alias gFbm='git flow bugfix pull'
# alias gFbx='git flow bugfix delete'
#
# alias gFll='git flow release list'
# alias gFls='git flow release start'
# alias gFlf='git flow release finish'
# alias gFlp='git flow release publish'
# alias gFlt='git flow release track'
# alias gFld='git flow release diff'
# alias gFlr='git flow release rebase'
# alias gFlc='git flow release checkout'
# alias gFlm='git flow release pull'
# alias gFlx='git flow release delete'
#
# alias gFhl='git flow hotfix list'
# alias gFhs='git flow hotfix start'
# alias gFhf='git flow hotfix finish'
# alias gFhp='git flow hotfix publish'
# alias gFht='git flow hotfix track'
# alias gFhd='git flow hotfix diff'
# alias gFhr='git flow hotfix rebase'
# alias gFhc='git flow hotfix checkout'
# alias gFhm='git flow hotfix pull'
# alias gFhx='git flow hotfix delete'
#
# alias gFsl='git flow support list'
# alias gFss='git flow support start'
# alias gFsf='git flow support finish'
# alias gFsp='git flow support publish'
# alias gFst='git flow support track'
# alias gFsd='git flow support diff'
# alias gFsr='git flow support rebase'
# alias gFsc='git flow support checkout'
# alias gFsm='git flow support pull'
# alias gFsx='git flow support delete'

# Grep (g)
# alias gg='git grep'
alias gg='git grep --ignore-case'
  alias ggl='git grep --files-with-matches'
  alias ggL='git grep --files-without-matches'
  alias ggv='git grep --invert-match'
  alias ggw='git grep --word-regexp'

# Index (i)
alias gia='git add'
alias giap='git add --patch'
alias giu='git add --update'
alias gid='git diff --no-ext-diff --cached'
alias giD='git diff --no-ext-diff --cached --word-diff'
alias gii='git update-index --assume-unchanged'
alias giI='git update-index --no-assume-unchanged'
alias gir='git reset'
alias girp='git reset --patch'
alias gix='git rm -r --cached'
alias giX='git rm -rf --cached'

# Log (l)
alias gl='git log --topo-order --pretty=format:"${_git_log_medium_format}"'
alias gls='git log --topo-order --stat --patch --full-diff --pretty=format:"${_git_log_medium_format}"'
alias glg='git log --topo-order --graph --pretty=format:"${_git_log_oneline_format}"'
alias gla='git log --topo-order --all --graph --pretty=format:"${_git_log_oneline_format}"'
# alias glb='git log --topo-order --pretty=format:"${_git_log_brief_format}"'
# alias gls='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
# alias glo='git log --topo-order --pretty=format:"${_git_log_oneline_format}"'
# alias glc='git shortlog --summary --numbered'
# alias glS='git log --show-signature'

# Merge (m)
alias gm='git merge'
alias gmC='git merge --no-commit'
alias gmF='git merge --no-ff'
alias gma='git merge --abort'
alias gmt='git mergetool'

# Push (p)
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpF='git push --force'
alias gpa='git push --all'
alias gpA='git push --all && git push --tags'
alias gpt='git push --tags'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gpp='git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'

# Remote (R)
alias gR='git remote'
alias gRl='git remote --verbose'
alias gRa='git remote add'
alias gRx='git remote rm'
alias gRm='git remote rename'
alias gRu='git remote update'
alias gRp='git remote prune'
alias gRs='git remote show'
alias gRb='git-hub-browse'

# Stash (s)
alias gs='git stash'
alias gsa='git stash apply'
alias gsx='git stash drop'
alias gsX='git-stash-clear-interactive'
alias gsl='git stash list'
alias gsL='git-stash-dropped'
alias gsd='git stash show --patch --stat'
alias gsp='git stash pop'
alias gsr='git-stash-recover'
alias gss='git stash save --include-untracked'
alias gsS='git stash save --patch --no-keep-index'
alias gsw='git stash save --include-untracked --keep-index'

# Submodule (S)
alias gS='git submodule'
alias gSa='git submodule add'
alias gSf='git submodule foreach'
alias gSi='git submodule init'
alias gSI='git submodule update --init --recursive'
alias gSl='git submodule status'
alias gSm='git-submodule-move'
alias gSs='git submodule sync'
alias gSu='git submodule foreach git pull origin master'
alias gSx='git-submodule-remove'

# Tag (t)
alias gt='git tag'
alias gtl='git tag -l'
alias gts='git tag -s'
alias gtv='git verify-tag'

# Working Copy (w)
alias gw='git status --ignore-submodules=${_git_status_ignore_submodules} --short'
alias gws='git status --ignore-submodules=${_git_status_ignore_submodules}'
alias gwd='git diff --no-ext-diff'
alias gwD='git diff --no-ext-diff --word-diff'
alias gwr='git reset --soft'
alias gwR='git reset --hard'
alias gwc='git clean -n'
alias gwC='git clean -f'
alias gwx='git rm -r'
alias gwX='git rm -rf'


function git_branch_list()
{
  local=$(git branch|perl -pe "s/\* /  /")
  no_branch=$(git branch -r|perl -pe "s/origin\///g"|perl -ne "print if ! /->/")
    no_branch=$(echo -ne "$local\n$no_branch"|sort|uniq -u)
    remote=$(git branch -r|perl -ne "print if ! /->/")

      local_print=$(echo $local|perl -pe "s/^  /  * /")
      no_branch_print=$(echo $no_branch|perl -pe "s/^  /  + /")
      remote_print=$(echo $remote|perl -pe "s/^  /  = /")

      echo -e "$local_print\n$no_branch_print\n$remote_print"
    }

  alias -g B='`git_branch_list| peco | sed -e "s/^\*[ ]*//g"`'

